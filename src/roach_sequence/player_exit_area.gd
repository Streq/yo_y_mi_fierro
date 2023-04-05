extends Area2D
signal player_inside
onready var target = Group.get_one("player")
	
func _physics_process(delta: float) -> void:
	if is_instance_valid(target) and overlaps_body(target):
		emit_signal("player_inside")
