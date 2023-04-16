extends Node
signal trigger
func _ready() -> void:
	get_parent().connect("selected",self,"trigger")

func trigger():
	synch()
	emit_signal("trigger")

func synch():
	Achievements.sync_achievements()
