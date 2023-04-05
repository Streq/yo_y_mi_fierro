extends Label
signal fully_visible()

var fully_visible = false
func _physics_process(delta: float) -> void:
	if !fully_visible and percent_visible == 1.0:
		fully_visible = true
		emit_signal("fully_visible")
		
