extends Node2D

onready var maps: Node = $maps

func _ready() -> void:
	randomize()
	add_child(maps.get_spawn().instance())
