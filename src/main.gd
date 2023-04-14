extends Node

func _ready() -> void:
	Text.clear_queue()
	Text.clear()
	GlobalPalette.reload()
	if !Global.language_chosen:
		MenuStack.push(LocaleMenu)
		yield(MenuStack,"empty")
	MenuStack.push(MainMenu)
	
