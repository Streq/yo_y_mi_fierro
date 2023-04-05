extends TextureRect
onready var locked: TextureRect = $locked
onready var focus_panel: TextureRect = $focus_panel

var completed := false

func completed():
	completed = true
	if locked:
		locked.hide()

func reset():
	completed = false
	if locked:
		locked.show()

func _ready() -> void:
	connect("focus_entered",focus_panel,"show")
	connect("focus_exited",focus_panel,"hide")
	if completed:
		completed()
	pass
