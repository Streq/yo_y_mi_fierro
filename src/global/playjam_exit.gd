extends Node

onready var restart_rect: ColorRect = $restart_rect

func win():
	restart()

func lose():
	restart()

func restart():
	restart_rect.visible = true
	yield(get_tree().create_timer(1.0),"timeout")
	GlobalPalette.reload()
	restart_rect.visible = false
	get_tree().change_scene("res://src/map/arcade_mode.tscn")
