extends Node

export var locale := "es"

func _ready() -> void:
	get_parent().connect("focused",self,"trigger")

func trigger():
	owner.set_locale(locale)
