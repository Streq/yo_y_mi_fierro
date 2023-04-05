extends Node

func _ready() -> void:
	get_parent().connect("weapon_change",self,"_on_weapon_change")

func _on_weapon_change(name):
	Global.weapon = name
	
