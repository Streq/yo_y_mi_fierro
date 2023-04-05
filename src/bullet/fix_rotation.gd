extends Node

onready var parent = get_parent()

func _process(delta: float) -> void:
	parent.global_rotation = 0.0
