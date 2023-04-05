extends HBoxContainer


export var dot : PackedScene
export var player_path : NodePath
onready var player = get_node(player_path)
func _ready() -> void:
	yield(owner,"ready")
	var health = player.health
	for i in health.max_value:
		var inst = dot.instance()
		add_child(inst)
	health.connect("value_changed", self,"_value_changed")

func _value_changed(value,max_value):
	for i in value:
		get_child(i).fill()
	for i in range(value,max_value):
		get_child(i).empty()
