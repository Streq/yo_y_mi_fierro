extends Node
signal finished()
onready var sprite: Sprite = $"%Sprite"

func play():
	var tween = create_tween()
	tween.tween_callback(sprite,"set_position",[Vector2(-1.0,0.0)])
	tween.tween_interval(0.1)
	tween.tween_callback(sprite,"set_position",[Vector2(1.0,0.0)])
	tween.tween_interval(0.1)
	tween.set_loops(5)
	yield(tween,"finished")
	emit_signal("finished")
