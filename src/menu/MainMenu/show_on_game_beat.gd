extends Node


func update():
	get_parent().visible = Achievements.unlocked_endless

func _ready() -> void:
	update()
