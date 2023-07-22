extends Node2D


func _ready() -> void:
	action("A")
	action("B")

func action(A):
	print(A)
	for event in InputMap.get_action_list(A):
		if event is InputEventKey:
			var key : InputEventKey = event
			print("KEY")
			print("scancode:",key.scancode)
			print("physical_scancode:",key.physical_scancode)
			print("keyboard_get_scancode_from_physical:",OS.keyboard_get_scancode_from_physical(key.physical_scancode))
			print("get_scancode_string from keyboard_get_scancode_from_physical:",OS.get_scancode_string(OS.keyboard_get_scancode_from_physical(key.physical_scancode)))
			
