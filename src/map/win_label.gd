extends Label
signal fully_visible()

export (Array, String, MULTILINE) var consignas

export var index_source : NodePath

func _ready() -> void:
	text = consignas[get_node(index_source).index]
	set_size(Vector2(get_size().x,0))

var fully_visible = false
func _physics_process(delta: float) -> void:
	if !fully_visible and percent_visible == 1.0:
		fully_visible = true
		emit_signal("fully_visible")
		
