extends Node

func _ready() -> void:
	if !OS.has_feature("pc"):
		get_parent().queue_free()
	get_parent().connect("selected",self,"trigger")

func trigger():
	get_tree().quit()
	
