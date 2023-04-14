extends Label


export var format = "HIGHSCORE:%d"
export var trigger_signal = "highscore_updated"
export var highscore_name = "highscore"
func _ready() -> void:
	Achievements.connect(trigger_signal, self, "update_text")
	update_text()
	LocaleMenu.connect("locale_changed",self,"update_text")
func update_text():
	text = tr(format) % Achievements.get(highscore_name)
