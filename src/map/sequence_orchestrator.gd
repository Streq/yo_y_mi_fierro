extends Node

onready var intro_anim: AnimationPlayer = $"../intro_anim"
onready var spawn_odds_change_animation: AnimationPlayer = $"../spawn_odds_change_animation"
onready var win_anim: AnimationPlayer = $"../win_anim"
onready var fade_out_win_anim: AnimationPlayer = $"../fade_out_win_anim"
onready var lose_anim: AnimationPlayer = $"../lose_anim"

onready var intro_label: Label = $"../CanvasLayer2/intro/intro_label"
onready var consigna_label: Label = $"../CanvasLayer2/intro/consigna_label"
onready var win_label: Label = $"../CanvasLayer2/win_label"
onready var lose_label: Label = $"../CanvasLayer2/lose_label"
onready var survive_label: Label = $"../CanvasLayer2/survive_label"

onready var intro_display_text: Node = $"../CanvasLayer2/intro/intro_label/display_text"
onready var consigna_display_text: Node = $"../CanvasLayer2/intro/consigna_label/display_text"
onready var win_display_text: Node = $"../CanvasLayer2/win_label/display_text"
onready var lose_display_text: Node = $"%display_text"
onready var survive_display_text: Node = $"%survive_display_text"

onready var fade_out: Node = $"../fade_out"

onready var time_left: Timer = $"../time_left"

onready var intro: Control = $"../CanvasLayer2/intro"
onready var howtoplay: TextureRect = $"%howtoplay"
onready var music: AudioStreamPlayer = $"%music"
onready var dead_enemies: Label = $"%dead_enemies"
onready var score: Label = $"%score"
onready var spawner: Node2D = $"../spawner"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GlobalPalette.reload()
	dead_enemies.hide()
	score.hide()
		
	if !Global.skip_intro:
		fade_out.blackout()
		fade_out.fade_in(false, 1.0)

		howtoplay.show()
		
		intro_anim.play("play")
		yield(get_tree().create_timer(0.5),"timeout")
		yield(show_label(intro_display_text),"completed")
		yield(get_tree().create_timer(0.2),"timeout")
		yield(show_label(consigna_display_text),"completed")
		howtoplay.show()
		yield(get_tree().create_timer(0.2),"timeout")
		yield(show_label(survive_display_text),"completed")
		yield(get_tree().create_timer(0.2),"timeout")
		dead_enemies.show()
		yield(get_tree().create_timer(0.2),"timeout")
		score.show()
		var hide_tween = create_tween()
		hide_tween.tween_callback(intro_label,"hide").set_delay(5.0)
		hide_tween.tween_callback(consigna_label,"hide")
		hide_tween.tween_callback(howtoplay,"hide")
		hide_tween.tween_callback(spawn_odds_change_animation,"play",["play"])
		hide_tween.tween_callback(time_left,"start")
		hide_tween.tween_callback(spawner,"activate")
		
		
	else:
		music.play()
		intro_label.hide()
		consigna_label.hide()
		howtoplay.hide()
		yield(show_label(survive_display_text),"completed")
		yield(get_tree().create_timer(0.2),"timeout")
		dead_enemies.show()
		yield(get_tree().create_timer(0.2),"timeout")
		score.show()
		
#		yield(fade_out,"finished_fade_in")

		spawn_odds_change_animation.play("play")
		time_left.start()
		spawner.activate()
	
	
	

func show_label(display_text:Node):
	display_text.time_per_char_in_seconds = 0.05
	var label = display_text.label
	
	var raw_text = label.text
	var text_parts = raw_text.split("${}")
	var full_text = text_parts.join("")
	
	label.text = full_text
	label.visible_characters = 0
	label.show()
	for i in range(0,text_parts.size()-1):
		yield(show_label_part(display_text, text_parts[i]),"completed")
		yield(get_tree().create_timer(0.2),"timeout")
	yield(show_label_part(display_text, text_parts[-1]),"completed")

func show_label_part(display_text:Node, part:String):
	var printable_character_count = StringUtils.count_printable_characters(part)
	display_text.display(printable_character_count)
	yield(display_text,"finished")

