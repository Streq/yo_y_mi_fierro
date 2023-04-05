extends Node

export var use_vector:=false
export var normalize_if_not_vector:=false
export var disabled := false

func _physics_process(delta: float) -> void:
	if disabled:
		return
	var input = get_parent().input_state
	input.A.pressed = Input.is_action_pressed("A")
	input.B.pressed = Input.is_action_pressed("B")
	if use_vector:
		input.dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	else:
		input.dir.x = Input.get_axis("ui_left","ui_right")
		input.dir.y = Input.get_axis("ui_up","ui_down")
		if normalize_if_not_vector:
			input.dir=input.dir.limit_length()
	
