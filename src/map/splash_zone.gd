extends Area2D
export var SPLASH : PackedScene



func _on_body_entered(body: Node) -> void:
	#fixed y otherwise different speed = different y
	if !body.dead:
		body.die()
	var y = global_position.y-4.0
	var x = body.global_position.x
	call_deferred("spawn_splash", Vector2(x,y))
	body.queue_free()

func spawn_splash(global_pos):
	var splash = SPLASH.instance()
	add_child(splash)
	splash.global_position = global_pos
	
