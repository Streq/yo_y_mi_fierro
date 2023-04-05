extends Node

func _ready() -> void:
	get_parent().connect("selected",self,"trigger")

func trigger():
	MenuStack.clear()
	get_tree().change_scene("res://src/main.tscn")
