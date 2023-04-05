extends Node2D
signal spawn(who)

export var SPAWN_SCENE : PackedScene



func spawn(target:Node2D):
	if !SPAWN_SCENE:
		return
	var entity:Node2D = SPAWN_SCENE.instance()
	entity.facing_dir = sign(target.global_position.x-global_position.x)
	get_parent().add_child(entity)
	entity.global_transform = global_transform
	entity.add_to_group("enemy")
	emit_signal("spawn", entity)


func _on_area_entered(area: Node2D) -> void:
	spawn(area)
	pass # Replace with function body.


func _on_screen_entered() -> void:
	var player = Group.get_one("player")
	if is_instance_valid(player):
		spawn(player)
	pass # Replace with function body.
