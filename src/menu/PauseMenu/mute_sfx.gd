extends Node

func _ready() -> void:
	get_parent().connect("selected",self,"trigger")
	LocaleMenu.connect("locale_changed",self,"retranslate")
	retranslate()

func trigger():
	var id = AudioServer.get_bus_index("sfx")
	AudioServer.set_bus_mute(id,!AudioServer.is_bus_mute(id))
	retranslate()
	
func retranslate():
	var id = AudioServer.get_bus_index("sfx")
	get_parent().text = tr("Sounds")+":"+ (tr("yes") if !AudioServer.is_bus_mute(id) else tr("no")) 
