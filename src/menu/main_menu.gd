extends Node2D

onready var entry_list: VBoxContainer = $CanvasLayer/VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in entry_list.get_children():
		child.undisplay()
	
	for child in entry_list.get_children():
		child.display()
		yield(child,"fully_visible")
		yield(get_tree().create_timer(0.025),"timeout")
	
	entry_list.focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
