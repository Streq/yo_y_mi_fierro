extends Node

export var degrees_increased_per_shot := 1.0

var accumulated = 0.0
export var max_accumulable = 45.0


func _on_trigger_pressed():
	pass
func _on_trigger_released():
	get_parent().spread_degrees -= accumulated
	accumulated = 0.0
	pass
func _on_shoot() -> void:
	if max_accumulable <= accumulated:
		return
	accumulated += degrees_increased_per_shot
	get_parent().spread_degrees += degrees_increased_per_shot
