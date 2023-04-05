extends Node2D
signal picked_up()
onready var effect: Node = $effect
onready var player_detect: Area2D = $player_detect
onready var lifetime: Timer = $lifetime
onready var pickup_sound: AudioStreamPlayer2D = $pickup_sound

var applied_already = false

func _on_player_detect_body_entered(body: Node) -> void:
	if applied_already:
		return
	applied_already = true
	effect.apply(body)
	emit_signal("picked_up")
	NodeUtils.reparent_keep_transform(pickup_sound,body)
	pickup_sound.play()
	queue_free()
