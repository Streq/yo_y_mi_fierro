extends AudioStreamPlayer2D

export var threshold_speed := 100.0

func _physics_process(delta: float) -> void:
	if !playing:
		if owner.dead and owner.velocity.y > threshold_speed:
			play()
	else:
		if !(owner.dead and owner.velocity.y > threshold_speed):
			stop()
		
