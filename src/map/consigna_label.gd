extends Label

export (Array, String,MULTILINE) var consignas

var index = 0

func _ready() -> void:
	randomize()
	index = randi()%consignas.size()
#	index = 5%consignas.size()
	text = tr(consignas[index])
	set_size(Vector2(get_size().x,0))
	
var fully_visible = false
