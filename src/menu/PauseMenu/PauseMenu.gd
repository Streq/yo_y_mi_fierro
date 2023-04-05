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
	
	
	emit_signal("enter")

func exit():
	hide()
	emit_signal("exit")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if MenuStack.empty():
			MenuStack.push(self)
		elif MenuStack.current() == self:
			MenuStack.pop()
		
