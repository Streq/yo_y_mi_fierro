extends Node


onready var drop_table: Node = $"%drop_table"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	refresh()
func refresh():
	for child in drop_table.get_children():
		if Global.weapon == child.name:
			child.weight = 1.0
		else:
			child.weight = 0.0
