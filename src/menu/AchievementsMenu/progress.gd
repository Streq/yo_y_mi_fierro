extends ProgressBar

export var timer_path : NodePath 
onready var timer : Timer = get_node(timer_path)
func _process(delta: float) -> void:
	if timer.is_stopped():
		value  = 0
		return
	max_value = timer.wait_time
	value = timer.wait_time - timer.time_left
	
