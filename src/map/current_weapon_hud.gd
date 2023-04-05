extends TextureRect

const PATH = "res://assets/texture/pickup/%s_pickup.png"
const WEAPONS = ["uzi","shotgun","burst","sniper","gun"]
var map = {}
func _ready():
	for weapon in WEAPONS:
		map[weapon] = load(get_tex_path(weapon))

func get_tex_path(name):
	return PATH % name


func _on_weapon_change(weapon):
	texture = map[weapon]
	pass
