extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var roach: KinematicBody2D = $"%roach"
onready var player: KinematicBody2D = $"../player"
onready var roach_controller: Node2D = $"%roach_controller"
onready var input_controller: Node = $"%input_controller"
onready var roach_detect: Area2D = $"%roach_detect"
onready var fade_out: Node = $"%fade_out"
onready var stage_clear_music: AudioStreamPlayer = $"%stage_clear_music"
onready var player_exit_area: Area2D = $"%player_exit_area"
onready var boss_bar: CanvasLayer = $"%boss_bar"
onready var intro: AudioStreamPlayer = $"%intro"
onready var fight: AudioStreamPlayer = $"%fight"

var player_hurt = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect("took_hit",self,"_on_player_hurt")
	player_exit_area.set_physics_process(false)
	player.hide()
	
	player.connect("die",self,"restart")
	
	boss_bar.hide()
	GlobalPalette.reload()
	fade_out.fade_in(false, 0.25)
	yield(fade_out,"finished_fade_in")
	yield(get_tree().create_timer(0.5),"timeout")
	player.show()
	
	player.input_state.dir.x = 1.0
	
	yield(get_tree().create_timer(0.25),"timeout")
	
	player.input_state.dir.x = 0.0

	yield(get_tree().create_timer(0.25),"timeout")
	
	Text.say_array(["Vos estás tapándole la entrada al baño a mi mujer?"])
	yield(Text,"finished")
	
	yield(get_tree().create_timer(0.5),"timeout")
	roach.facing_dir = -1.0
	yield(get_tree().create_timer(0.5),"timeout")
	
	intro.play()
	
	Text.say_array(["Sí gato cuál hay"],"roach")
	Text.say_array(["Que es mi casa y te tenés que ir."])
	
	Text.say_array(["Perdón no te escuché."],"roach")
	Text.say_array(["Es mi casa y te tenés que ir."])
	
	yield(Text,"finished")
	
	roach.input_state.dir = Vector2.LEFT
	yield(roach_detect,"body_entered")
	roach.input_state.dir = Vector2()
	for i in 2:
		yield(get_tree(),"physics_frame")
	
	
	Text.say_array(["Ahora sí gato decime."],"roach")
	
	Text.say_array(["Que esta es mi casa y te tenés que ir."])
	Text.say_array(["Las pelotas amigo, este baño es mío ahora y voy a hacer joda, ya compré el escabio. Así que tocá."],"roach")
	
	Text.say_array(["Me parece que no entendiste, si no te vas te mato."])
	Text.say_array(["Yo te mato a vos amigo"],"roach")
	yield(Text,"done_with_all_text")
	Text.can_skip = false
	Text.say_array(["No yo a vos amigo"])
	Text.say_array(["No yo a vos amigo"],"roach")
	yield(get_tree().create_timer(0.7),"timeout")
	Text.skip()
	Text.skip()
	Text.can_skip = true
	Text.say_array(["Bueno sabés qué, yo te avisé"])
	yield(Text,"finished")
	intro.stop()
	fight.play()
	roach_controller.disabled = false
	input_controller.disabled = false
	
	boss_bar.show()
	
	yield(roach,"die")
	fight.stop()
	while !roach.is_on_floor() or roach.velocity.y != 0.0 or !player.is_on_floor():
		yield(get_tree(),"physics_frame")
	
	player.input_state.clear()
	input_controller.disabled = true
	
	roach.input_state.clear()
	roach_controller.disabled = true
	get_tree().call_group("bullet","queue_free")
	
	yield(get_tree(),"physics_frame")
	
	var x_dist = roach.global_position.x - player.global_position.x
	player.facing_dir = x_dist
	
	yield(get_tree().create_timer(1.0), "timeout")

# VERSION 1
#	Text.say_array(["Ay auchi aw nooo me muero"],"roach")
#	Text.say_array(["Estabas avisado hermano"])
#	Text.say_array(["Cerra el culo gil, te voy a agarrar"],"roach")
#	Text.say_array(["te lo juro gato, si no te agarro yo te van a agarrar mis hijos"],"roach")
#	Text.say_array(["Los voy a estar esperando CAPO, ahora con permiso tengo que ir de cuerpo."])
#	Text.say_array(["Sí perdón"],"roach")

# VERSION 2
	Text.say_array(["Ay auchi aw nooo me muero"],"roach")
	Text.say_array(["Estabas avisado hermano"])
	yield(Text,"done_with_all_text")
	Text.say_array(["Era joda pelotudo, ahora vas a ver"],"roach")
	fight.play()
	roach.facing_dir = -x_dist
	roach.state_machine.current.goto("idle")
	
	yield(Text, "finished")
	var shake = roach.get_node("%shake")
	shake.play()
	yield(shake,"finished")
	fight.stop()
	Text.say_array(["Uh no estoy hecho cajeta"],"roach")
	
	yield(Text, "finished")
	roach.state_machine.current.goto("dead")
	
	yield(get_tree().create_timer(1.0),"timeout")
	
	Text.say_array(["Sí, ya era mucho si no"])
	yield(Text,"done_with_all_text")
	fight.play()
	roach.facing_dir = -x_dist
	roach.state_machine.current.goto("idle")
	Text.say_array(["Cerrá el culo gil, te voy a agarrar"],"roach")
	yield(Text,"finished")
	roach.state_machine.current.goto("dead")
	
	Text.say_array(["te lo juro gato, si no te agarro yo te van a agarrar mis hijos"],"roach")
	play_for(fight,1.0)
	yield(Text,"finished")
	Text.say_array(["Los voy a estar esperando CAPO, ahora con permiso tengo que ir de cuerpo."])
	
	yield(Text,"done_with_all_text")
	play_for(fight,1.0)
	Text.say_array(["dale tomatelás cagón"],"roach")
	yield(Text,"finished")
	fight.stop()
	roach.get_node("%death_free_anim").play()
	stage_clear_music.play()
	Text.say("GANASTE!!!!!")
	
	Achievements.complete("beat_boss")
	if !player_hurt:
		Achievements.complete("no_hurt_boss")
	player.input_state.dir.x = 1.0

	player_exit_area.set_physics_process(true)
	yield(player_exit_area,"player_inside")
	player.visible = false
	
	fade_out.fade_out(true,0.25)
	yield(fade_out,"finished_fade_out")
	if stage_clear_music.playing:
		yield(stage_clear_music,"finished")

	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://src/roach_sequence/ending.tscn")

func restart():
	yield(get_tree().create_timer(3.0),"timeout")
	Exit.restart()


func _input(event: InputEvent) -> void:
	if !OS.is_debug_build():
		return
	if event.is_pressed() and event is InputEventKey:
		var k :InputEventKey = event
		if k.scancode == KEY_W:
			roach.die()
func play_for(song,time):
	if !song.playing:
		song.play()
	yield(get_tree().create_timer(time),"timeout")
	song.stop()

func _on_player_hurt():
	player_hurt = true
