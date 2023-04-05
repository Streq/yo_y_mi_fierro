extends Label
export var timer_path: NodePath
onready var timer : Timer = get_node(timer_path)

func _process(delta: float) -> void:
	if !timer.is_stopped():
		text=tr("SOBREVIVI %02d SEGUNDOS") % ceil(timer.time_left)
