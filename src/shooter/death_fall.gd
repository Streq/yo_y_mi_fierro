extends Node

signal triggered()
export var chances := 0.4



func trigger():
	if chances and randf()<=chances:
		#make it so the dead dude falls through floors
		owner.set_collision_mask_bit(1, false)
		emit_signal("triggered")
