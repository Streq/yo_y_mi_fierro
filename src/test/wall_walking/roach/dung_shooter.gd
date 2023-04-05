extends Node2D
signal shoot
signal finished_shooting
signal trigger_released()
signal trigger_pressed()


export var cooldown := 0.0
onready var _cooldown_timer: Timer = $cooldown
var cooling_down = false
var shooting_muzzles = 0 setget set_shooting_muzzles

export var automatic := false
var trigger := ButtonState.new()

func shoot():
	if !cooling_down:
		emit_signal("shoot")
		if cooldown:
			cooling_down = true
			if is_shooting():
				yield(self,"finished_shooting")
			_cooldown_timer.start(cooldown)

func _on_cooldown_timeout() -> void:
	cooling_down = false

func get_world():
	return owner.get_parent()

func get_wearer():
	return owner
func is_shooting():
	return shooting_muzzles>0

func set_shooting_muzzles(val):
	shooting_muzzles = val
	
	if !shooting_muzzles:
		emit_signal("finished_shooting")

func _physics_process(delta: float) -> void:
	if trigger.is_pressed() and (automatic or trigger.just_updated):
		shoot()
	trigger.stale()

func press_trigger():
	set_trigger(true)
func release_trigger():
	set_trigger(false)
func set_trigger(val):
	trigger.pressed = val
	if trigger.just_updated:
		if val:
			emit_signal("trigger_pressed")
		else:
			emit_signal("trigger_released")
