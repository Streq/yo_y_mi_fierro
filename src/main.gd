extends Node

func _ready() -> void:
	if OS.has_feature("pc"):
		OS.window_fullscreen = true
	Text.clear_queue()
	Text.clear()
	GlobalPalette.reload()
	if !Global.language_chosen:
		MenuStack.push(LocaleMenu)
		yield(MenuStack,"empty")
	MenuStack.push(MainMenu)
