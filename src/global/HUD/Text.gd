extends CanvasLayer


signal finished()
signal player_pressed_A()

signal done_with_current_text()
signal done_with_all_text()
signal finished_loading()

signal display_text(text)
signal display_label(label)

onready var continue_label: Control = $continue
#onready var palette_client: Node = $"%palette_client"
onready var labels: Control = $"%labels"

export var skip_on_debug := false

var label_map = {}

const BASE_PALETTE = 9


var queue = []
var latest_stamp = 0

var label : Label = null

onready var timer: Timer = $Timer


func _ready() -> void:
	timer.connect("timeout",self,"done_with_current_text")
	for label in labels.get_children():
		label_map[label.name] = label
	
	clear()

func say(text, time := -1.0, theme := "default"):
	latest_stamp += 1
	done_with_current_text()
	update_theme(theme)
	label.text = text
	emit_signal("display_text",label.text)
	emit_signal("display_label",label)
	label.visible_characters = -1

	var current_stamp = latest_stamp
	
	if time>0.0:
		timer.start(time)
		yield(self, "done_with_current_text")
		if latest_stamp == current_stamp:
			clear_current_label()
			emit_signal("finished")
			
#	label.trigger()

func clear():
	for label in label_map.values():
		label.force_finish()
		label.text = ""
		label.hide()
	emit_signal("player_pressed_A")

func clear_current_label():
	if label:
		label.text = ""
		label.hide()

func clear_queue():
	queue = []

var processing = false

func say_and_wait_for_input(request):
	#FOR DEBUG
	if skip_on_debug and OS.is_debug_build():
		print(request)
		yield(get_tree(),"idle_frame")
		emit_signal("finished")
		return
	#FOR DEBUG
	
	Pause.pause(Pause.Level.TEXT)
	if queue or processing:
		queue.append(request)
		return
	clear_current_label()
		
	queue.append(request)
	
	while !queue.empty():
		processing = true
		latest_stamp += 1
		var next_request = queue.front()
		update_theme(next_request.theme)
		label.text = next_request.text
		emit_signal("display_text",label.text)
		emit_signal("display_label",label)
		label.trigger()
		yield(label,"finished")
		emit_signal("finished_loading")
		continue_label.display()
		yield(self, "player_pressed_A")
		clear_current_label()
		continue_label.hide()
		queue.pop_front()
		done_with_current_text()
	processing = false
	clear_current_label()
	unpause()
#	emit_signal("finished")
	
func say_array(texts,theme := "default"):
	for text in texts:
		say_and_wait_for_input({"text":text,"theme":theme})

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		emit_signal("player_pressed_A")
	if event.is_action_pressed("B", false) and can_skip:
		skip()

var can_skip = true
func skip():
	if label:
		if label.is_done():
			emit_signal("player_pressed_A")
		else:
			label.force_finish()
	
func unpause():
	for i in 2: #prevent jump after dialog end
		yield(get_tree(),"physics_frame")
	if !label.text:
		Pause.unpause(Pause.Level.TEXT)
		emit_signal("finished")

func done_with_current_text():
	emit_signal("done_with_current_text")
	if queue.empty():
		emit_signal("done_with_all_text")

func update_theme(theme):
	if label:
		label.hide()
	label = label_map[theme]
	label.show()
	continue_label.theme = label.theme
	continue_label.material = label.material
