extends Node

func _ready() -> void:
	GlobalPalette.reload()
	MenuStack.push(LocaleMenu)
	
	yield(MenuStack,"empty")
	get_tree().change_scene("res://src/map/arcade_mode.tscn")
