extends Node

onready var bar: Node = $bar


func increase(amount):
	bar.value += amount
	
func _physics_process(delta: float) -> void:
	bar.value -= delta
	if bar.value > 0.0:
		make_invulnerable()
	else:
		make_vulnerable()

func make_vulnerable():
	if owner.is_in_group("invulnerable"):
		owner.invulnerable = false
		owner.remove_from_group("invulnerable")
		owner.palette_animation.play("RESET")
		
func make_invulnerable():
	if !owner.is_in_group("invulnerable"):
		owner.invulnerable = true
		owner.add_to_group("invulnerable")
	if bar.value > 3.0 and owner.palette_animation.current_animation != "invulnerable":
		owner.palette_animation.play("invulnerable")
	elif owner.palette_animation.current_animation != "invulnerable_ending":
		owner.palette_animation.play("invulnerable_ending")
