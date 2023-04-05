extends Control

export var title := "" setget set_title
export var description := "" setget set_description
export var texture : Texture setget set_texture


func set_title(val):
	title = val
	$"%title".text = val

func set_description(val):
	description = val
	$"%description".text = val
	
func set_texture(val):
	texture = val
	$"%texture".texture = val
	
