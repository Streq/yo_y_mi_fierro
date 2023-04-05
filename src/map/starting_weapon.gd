extends Node2D

onready var drop_table: Node = $drop_table

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var drop = drop_table.get_spawn()
	if drop:
		var instance = drop.instance()
		get_parent().call_deferred("add_child",instance)
		instance.get_node("pickup_sound").volume_db=-100
		

func _unhandled_key_input(event: InputEventKey) -> void:
	if OS.is_debug_build():
		if event.is_pressed():
			var key = event.scancode - KEY_1
			if key >= 0 and key < drop_table.get_child_count():
				var drop = drop_table.get_child(key).scene
				get_parent().call_deferred("add_child",drop.instance())
