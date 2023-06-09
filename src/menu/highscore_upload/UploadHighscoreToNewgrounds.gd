extends CanvasLayer

signal enter()
signal exit()
signal retry(value)
onready var menu_stack = owner
onready var options: VBoxContainer = $"%options"
onready var uploading: Label = $"%uploading"
onready var failed: Label = $"%failed"
onready var success: Label = $"%success"
onready var retry: CenterContainer = $"%retry"
onready var skip: CenterContainer = $"%skip"

var should_give_up = false

func upload_highscore(request_body):
	silent_upload(request_body)

func loud_upload(request_body):
	MenuStack.push(self)
	should_give_up = false
	while !should_give_up:
		var request : HTTPRequest = NGIO.request(
			"ScoreBoard.postScore",
			request_body
		)
		if !request:
			MenuStack.pop()
			return
		uploading()
		var res = yield(request, "request_completed")
		var body_bytes : PoolByteArray = res[-1]
		var body = JSON.parse(body_bytes.get_string_from_ascii()).result
		if body.success:
			success()
			return
		elif should_give_up:
			return
		else:
			failed()
			var retry = yield(self, "retry")
			if !retry:
				return

func silent_upload(request_body):
	var request : HTTPRequest = NGIO.request(
		"ScoreBoard.postScore",
		request_body
	)
	

func _ready() -> void:
	exit()

func enter():
	show()
	refocus()
	emit_signal("enter")

func refocus():
	var i = 0
	var focusable = options.get_child(i)
	while !focusable.visible:
		i+=1
		focusable = options.get_child(i)
	focusable.grab_focus()
	var options_list = options.get_children()
	
	var back : Control = options_list.back()
	var front : Control = options_list.front()
	back.focus_neighbour_bottom = front.get_path()
	front.focus_neighbour_top = back.get_path()


func exit():
	hide()
	emit_signal("exit")

func uploading():
	failed.hide()
	uploading.show()
	success.hide()

	retry.hide()
	skip.show()

	refocus()

func failed():
	failed.show()
	uploading.hide()
	success.hide()

	retry.show()
	skip.show()
	
	refocus()

func success():
	failed.hide()
	uploading.hide()
	success.show()
	
	retry.hide()
	skip.hide()
	
	yield(get_tree().create_timer(1.5),"timeout")
	MenuStack.pop()
	
