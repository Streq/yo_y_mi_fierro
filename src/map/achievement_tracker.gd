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
	if val >= 30:
		Achievements.complete(("kill30"))
	if val >= 45:
		Achievements.complete("kill45")
	if val >= 60:
		Achievements.complete("kill60")
	if val >= 70:
		Achievements.complete("kill70")
	

func _on_win() -> void:
	Achievements.complete("beat_level")
	if !player_shot:
		Achievements.complete("pacifist")
	if !player_hurt:
		Achievements.complete("no_hurt")
	if eastern_enemies_left_alive == 0:
		Achievements.complete("kill_all_enemies_coming_from_right")
	if dead_enemies >= 20 and Global.weapon == "gun":
		Achievements.complete("starting_gun")
	if dead_enemies >= spawned_enemies:
		Achievements.complete("kill80")
	print("total spawned enemies:" + str(spawned_enemies))
func _on_spawner_spawn(who) -> void:
	spawned_enemies += 1
	if who.facing_dir < 0.0:
		eastern_enemies_left_alive += 1
		who.connect("die",self,"eastern_enemy_dead")
func eastern_enemy_dead():
	eastern_enemies_left_alive -= 1
	
