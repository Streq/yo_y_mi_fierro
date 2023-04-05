extends Node

signal empty()
signal value_changed(current_value, max_value)

export var max_value = 100.0 setget set_max_value
export var value = 100.0 setget set_value

var ready = false
func _ready():
	yield(owner,"ready")
	if value == max_value:
		value = owner.init_health_max
	max_value = owner.init_health_max
	
	
	ready = true
	set_max_value(max_value)
	set_value(value)

func set_value(val):
	value = clamp(val, 0, max_value)
	emit_signal("value_changed", value, max_value)
	if !value:
		emit_signal("empty")
func set_max_value(val):
	max_value = val
	if ready:
		emit_signal("value_changed", value, max_value)

func add_value(val):
	set_value(value+val)

func subtract(amount):
	set_value(value-amount)

func add(amount):
	set_value(value+amount)


#func _physics_process(delta):
#	pass
