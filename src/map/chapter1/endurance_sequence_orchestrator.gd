extends Node2D
onready var left_wall: CollisionShape2D = $"../player_boundaries/left_wall"
onready var camera: Camera2D = $"../camera"
onready var player_camera: Camera2D = $"../../player/Camera2D"
onready var player_detect: Area2D = $"../player_detect"
onready var spawn_odds_change_animation: AnimationPlayer = $"../spawn_odds_change_animation"
onready var time_left: Timer = $"../time_left"
onready var survive_label: Label = $"../CanvasLayer2/survive_label"
onready var survive_label_display_text: Node = $"../CanvasLayer2/survive_label/display_text"


func trigger():
	
	player_detect.disconnect("body_entered",self,"_on_player_detect_body_entered")
	left_wall.disabled = false
	camera.current = true
	camera.global_position = player_camera.get_camera_position()
	var xpos = 320
	var camera_tween = create_tween()
	camera_tween.tween_property(
		camera,
		"global_position",
		Vector2(xpos,0),
		2.0*(xpos-camera.global_position.x)/xpos
	).set_trans(Tween.TRANS_LINEAR)
	yield(camera_tween,"finished")
	survive_label_display_text.display()
	yield(survive_label_display_text,"finished")
	time_left.start()
	spawn_odds_change_animation.play("play")
	
	
func _on_player_detect_body_entered(body: Area2D) -> void:
	call_deferred("trigger")
	
