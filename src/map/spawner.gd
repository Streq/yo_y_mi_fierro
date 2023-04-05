extends Node2D
signal spawn(who)
export var point_source_path : NodePath
onready var point_source = get_node(point_source_path)

export var spawn_source_path : NodePath
onready var spawn_source = get_node(spawn_source_path)

func spawn():
	var spawn_point : SpawnPoint = point_source.get_point()
	var SPAWN_SCENE = spawn_source.get_spawn()
	if !SPAWN_SCENE:
		return
	var entity = SPAWN_SCENE.instance()
	entity.facing_dir = spawn_point.facing_dir
	
	
	
	get_parent().add_child(entity)
	entity.global_transform = spawn_point.global_transform
	entity.add_to_group("enemy")
	emit_signal("spawn", entity)
