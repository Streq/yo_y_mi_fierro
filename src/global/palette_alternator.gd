extends Node
enum TYPE {
	BACKGROUND,
	OBJECT
}
export (TYPE) var type : int
export var palette_index:=4
export var color_index0:=0
export var color_index1:=1

func trigger() -> void:
	var palette = GlobalPalette.get_palette(type,palette_index)
	var aux = palette.palette[color_index0]
	palette.palette[color_index0] = palette.palette[color_index1]
	palette.palette[color_index1] = aux


