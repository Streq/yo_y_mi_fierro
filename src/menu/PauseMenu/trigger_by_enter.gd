extends Node

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if MenuStack.empty():
			MenuStack.push(owner)
		elif MenuStack.current() == owner:
			MenuStack.pop()
		
