extends Node

onready var timer: Timer = $Timer
onready var progress: ProgressBar = $"%progress"


func _ready() -> void:
	get_parent().connect("lost_focus",self,"lost_focus")
	get_parent().connect("focused",self,"focused")
	timer.connect("timeout",self,"reset_progress")

func reset_progress():
	Achievements.clear()

func _process(delta: float) -> void:
	if Input.is_action_pressed("A") and timer.is_stopped():
		timer.start()
	
	if !Input.is_action_pressed("A"):
		timer.stop()


func lost_focus():
	timer.stop()
	
	set_process(false)

func focused():
	set_process(true)
