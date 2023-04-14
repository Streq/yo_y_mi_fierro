extends Node2D
signal dead_enemies_changed(val)
signal spawned_enemies_changed(val)
signal win()
signal score_changed(val)
onready var win_anim: AnimationPlayer = $win_anim
onready var fade_out_win_anim: AnimationPlayer = $fade_out_win_anim
onready var spawner_timer: Timer = $spawner/spawn_timer
onready var lose_anim: AnimationPlayer = $lose_anim
onready var consigna_label: Label = $CanvasLayer2/intro/consigna_label
onready var soldier: KinematicBody2D = $soldier

var outcome_decided = false
var dead_enemies = 0
var enemies_spawned = 0

var score := 0

func lose():
	if outcome_decided:
		return
	
	outcome_decided = true
	if is_instance_valid(consigna_label):
		consigna_label.visible = false
	lose_anim.play("play")
	Achievements.submit_highscore_endless(score)
	yield(lose_anim,"animation_finished")
	Exit.lose()
	pass
	
onready var win_display_text: Node = $CanvasLayer2/win_label/display_text


func _on_soldier_die() -> void:
	lose()

func _input(event: InputEvent) -> void:
	if OS.is_debug_build():
		if event is InputEventKey:
			if event.scancode == KEY_K:
				soldier.die()
			if event.scancode == KEY_B:
				get_tree().call_group("enemy","die")

func _enemy_died():
	dead_enemies += 1
	set_score(score + 100)
	emit_signal("dead_enemies_changed",dead_enemies)

func _player_hit():
	set_score(score - 10)
	

func _ready() -> void:
	emit_signal("dead_enemies_changed",dead_enemies)
	soldier.connect("took_hit",self,"_player_hit")
	
func _on_spawner_spawn(who) -> void:
	who.connect("die",self,"_enemy_died")
	enemies_spawned += 1
	emit_signal("spawned_enemies_changed",enemies_spawned)

func set_score(new_score):
	score = new_score
	emit_signal("score_changed",score)

func _physics_process(delta: float) -> void:
	if !outcome_decided:
		set_score(score + 1)
