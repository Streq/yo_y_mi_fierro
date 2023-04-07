extends TextureProgress



export var player_path : NodePath
onready var player = get_node(player_path)
func _ready() -> void:
	yield(owner,"ready")
	var shield = player.get_node("%shield")
	var bar = shield.bar
	bar.connect("value_changed", self,"_value_changed")

func _value_changed(value,max_value):
	self.max_value = max_value
	self.value = value
