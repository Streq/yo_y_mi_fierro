extends Label

export var format := "ENEMIGOS MUERTOS:%d"

func _ready() -> void:
	update_text(0)

func update_text(val):
	text = tr(format) % val
