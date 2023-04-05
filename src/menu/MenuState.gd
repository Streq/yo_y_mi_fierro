extends CanvasLayer

signal enter()
signal exit()


onready var menu_stack = owner


func enter():
	show()
	emit_signal("enter")

func exit():
	hide()
	emit_signal("exit")
	
