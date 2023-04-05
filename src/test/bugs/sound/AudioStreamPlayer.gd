extends AudioStreamPlayer

func _unhandled_key_input(event: InputEventKey) -> void:
	if event.scancode == KEY_SPACE:
		play()
