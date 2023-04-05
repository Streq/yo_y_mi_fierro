extends Node2D

export var knockback := Vector2()
export var damage := 1.0
export var disabled := false
var team := 0
export var team_owner_level := 1

func _ready() -> void:
	var _owner = owner
	for i in team_owner_level:
		_owner = _owner.owner
	
	team = owner.team
	

func disable():
	disabled = true
func enable():
	disabled = false

func _on_hitbox_area_entered(area: Area2D) -> void:
	if disabled:
		return
	if area.owner.team != team:
		area._on_hit(self)
	
func affect(enemy):
	var dirx = get_wearer().facing_dir
	enemy.velocity = Vector2(knockback.x*dirx, knockback.y)
	enemy.take_damage(damage)
	var turn_dir = -dirx
	
	enemy.facing_dir = turn_dir
func get_wearer():
	return owner.get_wearer() if owner.has_method("get_wearer") else owner
