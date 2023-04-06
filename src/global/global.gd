extends Node

"""
Achievements:
Workday over - Beat the war level
No Honey don't call the Exterminator - Beat the final boss
Show Off - Kill 30 enemy soldiers with the starting gun
Doctors hate him - Beat the war level without getting hurt
Good Shot, Good Soldier - Kill 45 enemy soldiers
No Way - Kill 60 enemy soldiers
Getting Rambo in this mf - Kill 70 enemy soldiers
God of the Battlefield - Kill all 80 enemies
How do I shoot - Beat the war level without shooting your gun
Shoulda Picked Another Bathroom Dumbass - Beat the final boss without getting hurt


"""



export var weapon := "gun"

export var skip_intro := false

func _unhandled_input(event: InputEvent) -> void:
	
#	if event.is_action_pressed("exit"):
#		get_tree().quit()
	if event.is_action_pressed("fullscreen"):
		change_fullscreen()
	if event.is_action_pressed("restart") and OS.is_debug_build():
		
		get_tree().change_scene("res://src/main.tscn")
#		get_tree().reload_current_scene()

func change_fullscreen():
	var current_screen = OS.current_screen
	OS.set_deferred("window_fullscreen", !OS.window_fullscreen)
	#due to bug
	for i in 3:
		yield(get_tree(),"idle_frame")
		OS.current_screen = current_screen

func _ready() -> void:
	OS.min_window_size=Vector2(
		ProjectSettings.get("display/window/size/width"),
		ProjectSettings.get("display/window/size/height")
	)

func is_playjam():
	return false
	return OS.has_feature("playjam")
