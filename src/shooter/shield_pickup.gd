extends Node

export var scene : PackedScene
export var weight : float setget, get_weight

func get_weight():
	if get_tree().has_group("invulnerable"):
		return 0
	else:
		return weight
func has_this_drop(player):
	return player.get_weapon_name() == name
