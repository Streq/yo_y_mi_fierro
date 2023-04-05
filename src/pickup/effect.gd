extends Node

export var WEAPON: PackedScene


func apply(on):
	var weapon = WEAPON.instance()
	on.change_weapon(weapon)
	
