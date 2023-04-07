extends Label
export var timer_path: NodePath
onready var timer : Timer = get_node(timer_path)

var done = false

func _process(delta: float) -> void:
	if !timer.is_stopped():
		text=tr("SOBREVIVI %02d SEGUNDOS") % ceil(timer.time_left)

func _ready() -> void:
	timer.connect("timeout",self,"timeout")

func timeout():
	hide()
