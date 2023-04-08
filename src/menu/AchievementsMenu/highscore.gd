extends Label


export var format = "HIGHSCORE:%d"
func _ready() -> void:
	Achievements.connect("highscore_updated",self,"update_text")
	update_text()

func update_text():
	text = format % Achievements.highscore
