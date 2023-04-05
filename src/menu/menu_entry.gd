extends Label

signal display()
signal undisplay()
signal fully_visible()

onready var full_rect: ColorRect = $MarginContainer/full_rect
onready var fade_rect: TextureRect = $MarginContainer/fade_rect
onready var display_text: Node = $display_text

func display():
	show()
	display_text.display()
	emit_signal("display")
	yield(display_text,"finished")
	emit_signal("fully_visible")

func undisplay():
#	hide()
	display_text.undisplay()
	emit_signal("undisplay")


func _on_focus_entered() -> void:
	fade_rect.visible=false
	full_rect.visible=true

func _on_focus_exited() -> void:
	fade_rect.visible=true
	full_rect.visible=false

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		print(event," ",get_index())
