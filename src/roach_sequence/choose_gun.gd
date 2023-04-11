extends CanvasLayer
signal enter()
signal exit()

onready var guns: HBoxContainer = $"%guns"

onready var selected_arrow: Node2D = $"%selected_arrow"
onready var selected_gun: Control = $"%selected_arrow".get_parent()



func _ready() -> void:
	for gun in guns.get_children():
		gun.connect("focus_entered",self,"focus_gun",[gun])
	exit()

func focus_gun(gun):
	NodeUtils.reparent(selected_arrow, gun)
	selected_gun = gun

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("B"):
		Global.weapon = selected_gun.name
		MenuStack.pop()

func enter():
	set_process_input(true)
	show()
	
	var focusable = guns.get_child(0)
	while focusable.focus_mode != Control.FOCUS_ALL:
		focusable = focusable.get_child(0)
	var last : Control = guns.get_children().back()
	last.focus_neighbour_right = focusable.get_path()
	focusable.focus_neighbour_left = last.get_path()
	for gun in guns.get_children():
		if gun.name == Global.weapon:
			gun.grab_focus()
	emit_signal("enter")

func exit():
	set_process_input(false)
	hide()
	emit_signal("exit")
