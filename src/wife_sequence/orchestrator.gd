extends Node

onready var wife: Sprite = $"%wife"
onready var player: KinematicBody2D = $"%player"
onready var input_controller: Node = $"%input_controller"
onready var fade_out: Node = $"%fade_out"
onready var player_close_to_wife_area: Area2D = $"%player_close_to_wife_area"
onready var heart: Sprite = $"../heart"
onready var player_exit_area: Area2D = $"%player_exit_area"
onready var music: AudioStreamPlayer = $"%music"

onready var music_start_timer: Timer = $"%music_start_timer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.hide()
	GlobalPalette.reload()
	fade_out.fade_in(true, 0.25)
	yield(fade_out,"finished_fade_in")
	yield(get_tree().create_timer(0.5),"timeout")
	music_start_timer.start()
	player.show()
	
	yield(get_tree().create_timer(0.5),"timeout")
	
	Text.say_array(["Amor ya llegué"])
	yield(Text,"finished")
	
	
	yield(get_tree().create_timer(0.25),"timeout")
	wife.scale.x = -1
	
	Text.say_array(["Ay amor justo! desde hoy que hay una cucaracha en el baño y no lo puedo usar!"],"wife")
	Text.say_array(["No te preocupes amor, Yo y Mi Fierro nos vamos a encargar."])
	
	yield(Text,"finished")
	player.input_state.dir.x = 1.0
	
	yield(player_close_to_wife_area,"player_inside")
	player.input_state.dir.x = 0.0
	heart.show()
	yield(get_tree().create_timer(0.5),"timeout")
	heart.hide()
	player.input_state.dir.x = 1.0
	
	yield(player_exit_area,"player_inside")
	player.hide()
	fade_out.fade_out(false, 0.25)
	yield(fade_out,"finished_fade_out")
	get_tree().change_scene("res://src/roach_sequence/roach_fight.tscn")
