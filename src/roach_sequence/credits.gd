extends Label
signal finished
onready var animation_player: AnimationPlayer = $"%AnimationPlayer"

func display():
	animation_player.play("play")
	yield(animation_player,"animation_finished")
	emit_signal("finished")


func _process(delta: float) -> void:
	var val = 0
	if (Input.is_action_pressed("ui_up") or 
		Input.is_action_pressed("A") or 
		Input.is_action_pressed("B")
	):
		val = 2
	if Input.is_action_pressed("ui_down"):
		val -= 6
	
	
	animation_player.playback_speed = pow(4,val)
	
