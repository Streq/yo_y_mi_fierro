extends Node

func _ready() -> void:
#	return
#	if true:
	if Global.is_playjam():
		for action in InputMap.get_actions():
			InputMap.action_erase_events(action)
		configure_A()
		configure_B()
		configure_left()
		configure_right()
		configure_up()
		configure_down()
		configure_exit()
	queue_free()

func configure_A():
	var action = "A"
	
	joy(action, JOY_XBOX_A)
	key(action, KEY_Z)
	mouse(action, BUTTON_LEFT)
	
func configure_B():
	var action = "B"
	
	joy(action, JOY_XBOX_Y)
	key(action, KEY_X)
	mouse(action, BUTTON_RIGHT)

func configure_left():
	var action = "ui_left"
	
	joy(action, JOY_DPAD_LEFT)
	key(action, KEY_LEFT)
	key(action, KEY_A)

func configure_right():
	var action = "ui_right"
	
	joy(action, JOY_DPAD_RIGHT)
	key(action, KEY_RIGHT)
	key(action, KEY_D)

func configure_up():
	var action = "ui_up"
	
	joy(action, JOY_DPAD_UP)
	key(action, KEY_UP)
	key(action, KEY_W)


func configure_down():
	var action = "ui_down"
	joy(action, JOY_DPAD_DOWN)
	key(action, KEY_DOWN)
	key(action, KEY_S)
	
func configure_exit():
	var action = "ui_cancel"
	key(action, KEY_ESCAPE)

func mouse(action, code):
	var mouseButton = InputEventMouseButton.new()
	mouseButton.button_index = code
	InputMap.action_add_event(action, mouseButton)

func joy(action, code):
	var joyButton = InputEventJoypadButton.new()
	joyButton.button_index = code
	InputMap.action_add_event(action, joyButton)

func key(action,code):
	var keyButton = InputEventKey.new()
	keyButton.scancode = code
	InputMap.action_add_event(action, keyButton)
