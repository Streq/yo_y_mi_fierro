extends Node
onready var credits: Label = $"%credits"

onready var music_start_timer: Timer = $"%music_start_timer"
onready var music: AudioStreamPlayer = $"%music"

func _ready() -> void:
	music_start_timer.start()
	GlobalPalette.reload()
	Text.say_array(["Y así es como nuestro héroe pudo ir al baño"],"narrator")
	yield(Text,"finished")
	
	Text.say("FIN",2.0,"narrator")
	
	yield(Text,"finished")
	credits.display()
	yield(credits,"finished")
	music.stop()
	Exit.restart()
	
