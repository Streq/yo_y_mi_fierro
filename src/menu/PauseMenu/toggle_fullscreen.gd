extends Node

func _ready() -> void:
	get_parent().connect("selected",self,"trigger")

func trigger():
	OS.window_fullscreen = !OS.window_fullscreen
	
