extends Node
signal trigger
func _ready() -> void:
	get_parent().connect("selected",self,"trigger")

func trigger():
	Achievements.sync_achievements()
	emit_signal("trigger")
