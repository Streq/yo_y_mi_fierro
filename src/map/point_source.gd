extends Node2D


func get_point() -> SpawnPoint:
	return get_child(randi()%get_child_count()) as SpawnPoint
