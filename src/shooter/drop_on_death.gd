extends Node

onready var drop_table: Node = $drop_table


func drop():
	var spawn = drop_table.get_spawn()
	if spawn:
		var inst = spawn.instance()
		owner.get_parent().call_deferred("add_child",inst)
		inst.set_deferred("global_position",owner.global_position)
