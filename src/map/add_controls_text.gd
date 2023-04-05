extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	yield(get_parent(),"ready")
	if !Global.is_playjam():
		get_parent().set_size(Vector2(get_parent().get_size().x,0))
	
