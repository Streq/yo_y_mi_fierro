extends Node

func _ready() -> void:
	get_parent().connect("selected",self,"trigger")
	LocaleMenu.connect("locale_changed",self,"retranslate")
	retranslate()

func trigger():
	Global.skip_intro = !Global.skip_intro
	retranslate()
	
func retranslate():
	get_parent().text = tr("Skip Intro")+":"+ (tr("yes") if Global.skip_intro else tr("no")) 
