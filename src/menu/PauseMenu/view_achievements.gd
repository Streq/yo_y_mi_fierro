extends Node

func _ready() -> void:
	get_parent().connect("selected",self,"trigger")

func trigger():
	MenuStack.push(AchievementsMenu)
	
