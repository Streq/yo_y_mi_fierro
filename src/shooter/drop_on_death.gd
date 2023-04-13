extends Node

onready var drop_table: Node = $drop_table
onready var global_drop_chance: Node = Group.get_one("global_drop_chance")


func drop():
	var spawn = drop_table.get_spawn()
	
	if spawn.scene:
		if !global_odds_allow_it(spawn.name):
			return
		var inst = spawn.scene.instance()
		owner.get_parent().call_deferred("add_child",inst)
		inst.set_deferred("global_position",owner.global_position)

func global_odds_allow_it(spawn_name):
	if (is_instance_valid(global_drop_chance) 
	and global_drop_chance.map.has(spawn_name)):
		return randf() < global_drop_chance.map[spawn_name].value
	return true
