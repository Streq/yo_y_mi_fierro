extends Node

export var scene : PackedScene
export var weight : float setget, get_weight

func get_weight():
	var player = Group.get_one("player")
	if is_instance_valid(player) and has_this_drop(player):
		return 0
	elif is_instance_valid(player) and has_drop(player, "gun"):
		return weight*4
	else:
		return weight
	
func has_this_drop(player):
	return player.get_weapon_name() == name

func has_drop(player, name):
	return player.get_weapon_name() == name
