extends Node


onready var input : InputState = owner.get_node("%input_state")

onready var r = owner

func update_rotation():
	pass

func stick_to_wall():
	pass
func premove(delta):
	if r.floor_normal and r.is_on_wall:
		r.velocity -= r.floor_normal*100.0
	else:
		r.velocity += r.gravity*delta
	
func move(delta):
	r.velocity = r.move_and_slide(r.velocity)
func postmove(delta):
	update_floor_normal()
	fix_rotation_to_ground()
	
	r.is_on_wall = r.is_on_wall()
	
	var last_wall = r.world
	r.ground = null
	if r.get_slide_count():
		last_wall = r.get_slide_collision(r.get_slide_count()-1).collider
		r.ground = last_wall

	r.is_in_concave_corner = r.floor_normal.x and r.floor_normal.y
	if last_wall != r.get_parent():
		r.call_deferred("reparent_to_wall",last_wall)

func update_floor_normal():
	r.floor_normal = Vector2()
	for i in r.get_slide_count():
		var collision : KinematicCollision2D = r.get_slide_collision(i)
		var normal := collision.normal
#		velocity -= velocity.project(normal)*2.0
		r.floor_normal += normal
func fix_rotation_to_ground():
	if r.is_on_wall:
		r.pivot.global_rotation = (-r.floor_normal.tangent()).angle()

