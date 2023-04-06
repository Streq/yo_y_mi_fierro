extends Node

func _ready() -> void:
	get_parent().connect("selected",self,"trigger")
	LocaleMenu.connect("locale_changed",self,"retranslate")
	retranslate()

func trigger():
	OS.window_fullscreen = !OS.window_fullscreen
	retranslate()
	
func retranslate():
	get_parent().text = tr("Full Screen")+":"+ (tr("yes") if OS.window_fullscreen else tr("no")) 
