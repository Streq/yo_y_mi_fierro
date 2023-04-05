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
export var gravity := 150.0
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
	
func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)

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
	
func change_weapon(new_weapon):
	gun_hold.remove_gun()
	gun_hold.add_gun(new_weapon)
	emit_signal("weapon_change", new_weapon.name)

func get_weapon_name():
	if gun_hold.gun:
		return gun_hold.gun.name
	else:
		return ""

var floor_normal := Vector2()
var up_vector := Vector2.UP
func update_wall_normal():
	floor_normal = Vector2()
	for i in get_slide_count():
		var collision := get_slide_collision(i)
		var normal := collision.normal
#		velocity -= velocity.project(normal)*2.0
		floor_normal += normal
