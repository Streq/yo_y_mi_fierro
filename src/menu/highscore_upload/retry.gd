extends Node

func _ready() -> void:
	get_parent().connect("selected",self,"trigger")

func trigger():
	owner.emit_signal("retry",true)
