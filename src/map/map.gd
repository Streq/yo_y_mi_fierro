extends Node2D
signal dead_enemies_changed(val)
signal spawned_enemies_changed(val)
signal win()

onready var win_anim: AnimationPlayer = $win_anim
onready var fade_out_win_anim: AnimationPlayer = $fade_out_win_anim
onready var time_left: Timer = $time_left
onready var spawner_timer: Timer = $spawner/Timer
onready var lose_anim: AnimationPlayer = $lose_anim
onready var consigna_label: Label = $CanvasLayer2/intro/consigna_label
onready var soldier: KinematicBody2D = $soldier

var outcome_decided = false
var dead_enemies = 0
var enemies_spawned = 0

func lose():
	if outcome_decided:
		return
	
	outcome_decided = true
	if is_instance_valid(consigna_label):
		consigna_label.visible = false
	time_left.paused = true
	lose_anim.play("play")
	yield(lose_anim,"animation_finished")
	Exit.lose()
	pass
	
onready var win_display_text: Node = $CanvasLayer2/win_label/display_text

func win():
	if outcome_decided:
		return
	
	outcome_decided = true
	
	
	if is_instance_valid(consigna_label):
		consigna_label.visible = false
	win_anim.play("play")
	spawner_timer.paused = true
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME,"enemy","die")
	emit_signal("win")
	
	yield(win_display_text, "finished")
	fade_out_win_anim.play("play")
	yield(fade_out_win_anim,"animation_finished")
	get_tree().change_scene("res://src/wife_sequence/wife_scene.tscn")
#	Exit.win()
	pass

func _on_time_left_timeout() -> void:
	win()

func _on_soldier_die() -> void:
	lose()

func _input(event: InputEvent) -> void:
	if OS.is_debug_build():
		if event is InputEventKey:
			if event.scancode == KEY_K:
				soldier.die()
			if event.scancode == KEY_B:
				get_tree().call_group("enemy","die")
			if event.scancode == KEY_W:
				win()

func _enemy_died():
	dead_enemies += 1
	emit_signal("dead_enemies_changed",dead_enemies)


func _ready() -> void:
	emit_signal("dead_enemies_changed",dead_enemies)
	
func _on_spawner_spawn(who) -> void:
	who.connect("die",self,"_enemy_died")
	enemies_spawned += 1
	emit_signal("spawned_enemies_changed",enemies_spawned)
