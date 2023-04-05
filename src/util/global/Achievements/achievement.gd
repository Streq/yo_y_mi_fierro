extends Node
class_name Achievement

signal completed
signal reset

export var title := ""
export var description := ""
export var completed := false setget set_completed
export var texture : Texture
export var hidden := false


func set_completed(val):
	completed = val
	if completed:
		emit_signal("completed")
	else:
		emit_signal("reset")
