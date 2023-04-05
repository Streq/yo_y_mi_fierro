extends TextureRect
onready var palette_client: Node = $palette_client

func fill():
	palette_client.index = 6
	pass

func empty():
	palette_client.index = 4
	pass
