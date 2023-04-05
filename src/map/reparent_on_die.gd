extends Node


func _ready() -> void:
	get_parent().get_parent().connect("die",self,"_on_die")

func _on_die():
	var pos = get_parent().get_camera_position()
	NodeUtils.reparent(get_parent(), get_parent().get_parent().get_parent())
	get_parent().drag_margin_h_enabled=false
	get_parent().global_position = pos

