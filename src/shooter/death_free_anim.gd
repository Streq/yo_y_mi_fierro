extends Node

onready var death_anim: AnimationPlayer = $death_anim

func _ready() -> void:
	death_anim.connect("animation_finished",self,"_animation_finished")
	
func _animation_finished(name):
	owner.queue_free()

func play():
	death_anim.play("play")
