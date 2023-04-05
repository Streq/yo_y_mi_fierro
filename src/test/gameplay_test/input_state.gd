extends Node
class_name InputState
var A := ButtonState.new()
var B := ButtonState.new()
var dir := Vector2()

func stale():
	A.stale()
	B.stale()

func _physics_process(delta: float) -> void:
	stale()


static func is_jump_down_dir(dir:Vector2):
	return dir.y>=0.95

static func get_turn_dir(dir:Vector2):
	return sign(dir.x)

static func get_run_dir(dir:Vector2):
#	return sign(dir.x) if dir.length() > 0.90 else 0
	return sign(dir.x) if dir.length() > 0.90 and abs(dir.x)>0.2 else 0


func get_local_dir():
	return dir.rotated(-owner.global_rotation)
func set_local_dir(val:Vector2):
	dir = val.rotated(owner.global_rotation)

func clear():
	A.pressed = false
	B.pressed = false
	stale()
	dir = Vector2()
