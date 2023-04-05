extends Node2D

export var disabled := false

onready var roach : KinematicBody2D = get_parent()

var walk_dir := Vector2.RIGHT

var target_pos := Vector2()

func _physics_process(delta: float) -> void:
	if disabled:
		return
	var input = roach.input_state
	
	if roach.state_machine.current.name == "shoot":
		input.dir = global_position.direction_to(get_target_pos())
		return
	#ESTADOS
	#CAMINANDO
	#camina en una direccion
	input.set_local_dir(walk_dir)

	#se puede dar vuelta aleatoriamente cuando no esta en el piso
	if roach.rotation != 0.0 and roach.is_on_floor():
		if randf()<0.01:
			walk_dir = Vector2(-roach.facing_dir, 0.0)
	#puede frenar y disparar mierda 
	if roach.rotation != 0.0 and roach.is_on_floor():
		if randf()<0.01:
			input.B.pressed = false
			input.B.pressed = true
	
	#si esta en diagonal al jugador o arriba de el puede volar hacia el
	if roach.rotation != 0.0 and roach.is_on_floor():
#	if roach.is_on_floor():
		if randf()<0.01:
			
			target_pos = global_position + global_position.direction_to(get_target_pos())*2000.0
			walk_dir = global_position.direction_to(target_pos)
			input.A.pressed = false
			input.A.pressed = true

	
	if roach.state_machine.current.name == "fly":
#		if randf()<0.005:
#			target_pos = global_position + global_position.direction_to(Group.get_one("player").global_position)*2000.0
		walk_dir = global_position.direction_to(target_pos)
	else:
		walk_dir = Vector2(sign(walk_dir.x) if walk_dir.x else 1.0, 0.0)
func get_target_pos():
	var target = Group.get_one("player")
	if target:
		return target.global_position
	return global_position
