extends Node

func _ready() -> void:
	get_parent().connect("selected",self,"trigger")

func trigger():
	get_tree().change_scene("res://src/endless_mode/endless_mode.tscn")
	MenuStack.clear()
