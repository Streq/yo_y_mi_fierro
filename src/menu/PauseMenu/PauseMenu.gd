extends CanvasLayer

signal enter()
signal exit()


onready var menu_stack = owner
onready var options: VBoxContainer = $"%options"

func _ready() -> void:
	exit()

func enter():
	show()
	
	var focusable = options.get_child(0)
	while focusable.focus_mode != Control.FOCUS_ALL:
		focusable = focusable.get_child(0)
	focusable.grab_focus()
	var last : Control = options.get_children().back()
	last.focus_neighbour_bottom = focusable.get_path()
	focusable.focus_neighbour_top = last.get_path()
	
	emit_signal("enter")

func exit():
	hide()
	emit_signal("exit")

