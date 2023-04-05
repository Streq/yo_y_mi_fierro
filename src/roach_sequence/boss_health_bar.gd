extends TextureProgress

export var boss_node : NodePath

var boss

func _ready() -> void:
	boss = get_node(boss_node)
	
	var health = boss.get_node("%health")
	health.connect("value_changed",self,"value_changed")


func value_changed(value,max_value):
	self.value = value
	self.max_value = max_value
