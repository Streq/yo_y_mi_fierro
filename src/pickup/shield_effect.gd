extends Node

export var time := 5.0
export var ending := 3.0

func apply(on:Node):
	if on.is_in_group("invulnerable"):
		return
	NodeUtils.reparent(self,on)
	on.invulnerable = true
	on.palette_animation.play("invulnerable")
	on.add_to_group("invulnerable")
	yield(get_tree().create_timer(time),"timeout")
	on.palette_animation.play("invulnerable_ending")
	yield(get_tree().create_timer(ending),"timeout")
	on.remove_from_group("invulnerable")
	on.invulnerable = false
	on.palette_animation.play("RESET")
	queue_free()
	pass
