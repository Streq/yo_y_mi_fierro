extends KinematicBody2D

signal got_hit(by)
signal took_hit()
signal took_damage(amount)
signal healed(amount)
signal die()
signal weapon_change(name)

export var velocity := Vector2()


export var walk_speed := 60.0
export var run_speed := 120.0
export var jump_speed := 125.0
export var team := 0
export (float, 0, 60) var idle_lerp := 7
export (float, 0, 60) var stop_lerp := 10
export (float, 0, 60) var run_lerp := 10
export (float, 0, 60) var air_lerp := 1
export (float, 0, 60) var air_run_lerp := 4
export (float, 0, 60) var air_dead_lerp := 0.5
export var palette_override := -1 

export var init_health_max := 100.0


onready var input_state: Node = $input_state
onready var state_animation: AnimationPlayer = $state_animation
onready var palette_animation: AnimationPlayer = $palette_animation
onready var pivot: Node2D = $pivot
onready var state_machine: Node = $state_machine
onready var palette_client: Node = $pivot/Sprite/palette_client
onready var gun_hold: Node2D = $pivot/gun_pivot/gun_hold
onready var health: Node = $health
onready var blindado: AudioStreamPlayer2D = $blindado

export var facing_dir = 1.0 setget set_facing_dir

var ready = false
var dead = false
var invulnerable = false

func _ready() -> void:
	ready = true
	state_machine.initialize()
	if palette_override >= 0:
		palette_client.index = palette_override
	set_facing_dir(facing_dir)
	

func turn_around():
	set_facing_dir(sign(-facing_dir))

func set_facing_dir(val):
	if !val:
		return
	facing_dir = sign(val)
	if ready:
		pivot.scale.x = facing_dir*abs(pivot.scale.x)

func get_hit(by):
	by.affect(self)
	if !invulnerable:
		palette_animation.play("hurt")
		emit_signal("got_hit",by)
		emit_signal("took_hit")
	else:
		blindado.play()

func take_damage(amount):
	if !invulnerable:
		emit_signal("took_damage", amount)

func heal(amount):
	emit_signal("healed", amount)

func die():
	state_machine._change_state("dead_air")
	if is_on_floor():
		velocity.y-=25.0

	if dead:
		return
	dead = true
	emit_signal("die")
	


export var gravity := Vector2(0,100)

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	
	
func get_floor_normal():
	return Vector2.UP.rotated(global_rotation)

func get_local_input_dir():
	var dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	var local_dir = dir.rotated(-global_rotation)
	return local_dir

func get_jump_input():
	return Input.is_action_just_pressed("A")

func stick_to_wall():
	var final_rotation = global_rotation
	var current_normal = get_floor_normal()
	
	for i in get_slide_count():
		var collision := get_slide_collision(i)
		var new_normal = collision.normal.round()
		if !new_normal.is_equal_approx(current_normal):
			final_rotation = Vector2.UP.angle_to(collision.normal)
			break
	global_rotation = final_rotation
