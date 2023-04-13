extends Label

export var format = "TIEMPO SOBREVIVIDO:%d"
var time = 0.0
func _physics_process(delta: float) -> void:
	time += delta
	text = tr(format) % time
onready var soldier: KinematicBody2D = $"%soldier"

func _ready() -> void:
	soldier.connect("die",self,"set_physics_process",[false])
