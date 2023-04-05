extends Node

func _physics_process(delta: float) -> void:
	get_parent().feed_state(Input.get_vector("ui_left","ui_right","ui_up","ui_down"),Input.is_action_pressed("A"),Input.is_action_pressed("B"))
	
