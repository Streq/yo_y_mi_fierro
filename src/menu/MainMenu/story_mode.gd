extends Node

func _ready() -> void:
	get_parent().connect("selected",self,"trigger")

func trigger():
	get_tree().change_scene("res://src/map/arcade_mode.tscn")
	MenuStack.clear()
