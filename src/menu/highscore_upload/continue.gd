extends Node

func _ready() -> void:
	get_parent().connect("selected",self,"trigger")

func trigger():
	owner.should_give_up = true
	MenuStack.pop()
	owner.emit_signal("retry",false)
