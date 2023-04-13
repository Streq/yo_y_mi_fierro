extends Node
onready var soldier: KinematicBody2D = $"%soldier"

var player_shot = false

var player_hurt = false
var eastern_enemies_left_alive = 0
var dead_enemies = 0
var spawned_enemies = 0

func _ready() -> void:
	soldier.get_node("%gun_hold").connect("trigger_pressed",self,"_on_player_shot")
	soldier.connect("took_hit",self,"_on_player_hit")

func _on_player_shot():
	player_shot = true

func _on_player_hit():
	player_hurt = true

func _on_dead_enemies_changed(val) -> void:
	dead_enemies = val

func _on_win() -> void:
	pass
func _on_spawner_spawn(who) -> void:
	spawned_enemies += 1
	if who.facing_dir < 0.0:
		eastern_enemies_left_alive += 1
		who.connect("die",self,"eastern_enemy_dead")
func eastern_enemy_dead():
	eastern_enemies_left_alive -= 1
	pass	
