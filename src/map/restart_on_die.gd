extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	yield(get_parent(), "die")
	NodeUtils.reparent(self, get_parent().get_parent())
	yield(get_tree().create_timer(1.0),"timeout")
	get_tree().reload_current_scene()

