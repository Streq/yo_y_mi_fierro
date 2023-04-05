extends Node2D
signal fired_bullet()
signal fired_shot()
export var base_shoot_speed = 250.0
export var rand_added_speed = 20.0
export var amount = 5

export var spread_degrees = 5.0
export var carried_inertia_from_shooter := 0.0

export var recoil := 0.0

export var override_drag := -1.0
export var override_movement_threshold_squared := -1.0
export var override_scale := Vector2()
export var override_targets_hit_before_despawn := 0
export var override_knockback := -1.0
export var override_damage := -1.0

export var time_between_shots := 0.0

#export var pool_name := "gun_bullet_pool"

export var BULLET : PackedScene

var shooting = false

#var pool
func _ready() -> void:
#	pool = Group.get_one(pool_name)
	pass	
func shoot(wearer = owner.owner):
	var min_angle = deg2rad(-spread_degrees)
	var max_angle = deg2rad(spread_degrees)
	
	owner.shooting_muzzles += 1
	for i in amount:
		var rot = global_rotation + rand_range(min_angle, max_angle)
		shoot_bullet(
				wearer, 
				rot,
				base_shoot_speed + rand_range(0, rand_added_speed)
			)
		if wearer:
			wearer.velocity -= Vector2.RIGHT.rotated(rot)*recoil/amount
		if time_between_shots:
			yield(get_tree().create_timer(time_between_shots),"timeout")
	
	owner.shooting_muzzles -= 1
	emit_signal("fired_shot")
func shoot_bullet(wearer = owner, angle = 0.0, power = 0.0):
	var bullet = instance_bullet()
	if bullet:
		bullet.global_position = global_position
		var bullet_vel = Vector2.RIGHT.rotated(angle)*power
		bullet.velocity = bullet_vel + carried_inertia_from_shooter*wearer.velocity
		bullet.global_rotation = bullet_vel.angle()
		bullet.scale*=scale
		bullet.team = wearer.team
		if override_drag >= 0.0:
			bullet.drag = override_drag
		if override_movement_threshold_squared >= 0.0:
			bullet.movement_threshold_squared = override_movement_threshold_squared
		if override_scale:
			bullet.scale = override_scale
		if override_targets_hit_before_despawn:
			bullet.targets_hit_before_despawn = override_targets_hit_before_despawn
		if override_knockback >= 0.0:
			bullet.knockback = override_knockback
		if override_damage >= 0.0:
			bullet.damage = override_damage
	emit_signal("fired_bullet")
func instance_bullet():
#	return pool.get_one()
	var bullet = BULLET.instance()
	owner.get_world().add_child(bullet)
	return bullet
