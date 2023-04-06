extends Node

func _ready() -> void:
	get_parent().connect("selected",self,"trigger")
	LocaleMenu.connect("locale_changed",self,"retranslate")
	retranslate()

func trigger():
	var id = AudioServer.get_bus_index("music")
	AudioServer.set_bus_mute(id,!AudioServer.is_bus_mute(id))
	retranslate()
	
func retranslate():
	var id = AudioServer.get_bus_index("music")
	get_parent().text = tr("Music")+":"+ (tr("yes") if !AudioServer.is_bus_mute(id) else tr("no")) 
