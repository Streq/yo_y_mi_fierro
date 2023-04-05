extends Node
onready var timer: Timer = $Timer
onready var despawning_anim: AnimationPlayer = $despawning_anim
export var despawning_time := 3.0

func _ready() -> void:
	yield(owner,"ready")
	timer.connect("timeout",self,"_on_timer_timeout")
	timer.start(owner.lifetime.wait_time-despawning_time)

func _on_timer_timeout() -> void:
	despawning_anim.play("play")
