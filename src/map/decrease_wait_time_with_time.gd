extends Node

export var min_time := 0.5
export var time_step := 0.25


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Timer_timeout() -> void:
	var timer = get_parent()
	timer.wait_time = max(min_time,timer.wait_time-time_step)
	
