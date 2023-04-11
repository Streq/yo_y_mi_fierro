extends Node


onready var fade_out: Node = $"%fade_out"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalPalette.reload()
	fade_out.fade_in(false, 0.2)
		
	
	
	MenuStack.push(ChooseGunMenu)
	yield(MenuStack,"empty")
	get_tree().change_scene("res://src/roach_sequence/roach_fight.tscn")
