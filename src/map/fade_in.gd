extends Node
signal finished_fade_in()
signal started_fade_in()
signal finished_fade_out()
signal started_fade_out()

var base_bg = []
var base_obj = []

export var delay_obj_bg := 0.2
export var fade_in_step_time := 1.0
export var fade_out_step_time := 1.0
export var fade_level := 2

var white = false

func fade_to_white(step_time_override := -1.0):
	fade_out(true, step_time_override)
func fade_to_black(step_time_override := -1.0):
	fade_out(false, step_time_override)
	
func fade_in(white := false, step_time_override := -1.0):
	self.white = white
	emit_signal("started_fade_in")
	var step_time = step_time_override if step_time_override>=0.0 else fade_in_step_time
	fade_in_obj(white, step_time)
	yield(create_timer(delay_obj_bg),"timeout")
	fade_in_bg(white, step_time)

func fade_in_bg(white:bool = false, step_time:=1.0):
	var background_palettes = GlobalPalette.background_palettes
	for n in fade_level:
		yield(create_timer(step_time),"timeout")
		for i in background_palettes.size():
			var background_palette : Palette = background_palettes[i]
			var shift_color = PoolColorArray([base_bg[i][fade_level-1-n]])
			background_palette.palette = ColorUtils.shift_palette_right(
					background_palette.palette, 
					shift_color
				)[0]
	emit_signal("finished_fade_in")

func fade_in_obj(white:bool = false, step_time:=1.0):
	var object_palettes = GlobalPalette.object_palettes
	for n in fade_level:
		yield(create_timer(step_time),"timeout")
		for i in object_palettes.size():
			var object_palette : Palette = object_palettes[i]
			var shift_color = PoolColorArray([base_obj[i][fade_level-1-n]])
			object_palette.palette = ColorUtils.shift_palette_right(
					object_palette.palette, 
					shift_color
				)[0]
		
func fade_out(white:bool = false,step_time_override := -1.0):
	self.white = white
	emit_signal("started_fade_out")
	fade_out_bg(white, step_time_override if step_time_override>=0 else fade_out_step_time)
	yield(create_timer(delay_obj_bg),"timeout")
	fade_out_obj(white, step_time_override if step_time_override>=0 else fade_out_step_time)



func fade_out_bg(white:bool = false, step_time:= 1.0):
	var black = PoolColorArray([Color.black])
	if white:
		black[0] = Color.white
	for i in 4:
		yield(create_timer(step_time),"timeout")
		for palette in GlobalPalette.background_palettes:
			var p : Palette = palette
			if white:
				p.palette = ColorUtils.shift_palette_right(p.palette, black)[0]
			else:
				p.palette = ColorUtils.shift_palette_left(p.palette, black)[0]
			

func fade_out_obj(white:bool = false, step_time := 1.0):
	var black = PoolColorArray([Color.black])
	if white:
		black[0] = Color.white
	for i in 4:
		yield(create_timer(step_time),"timeout")
		for palette in GlobalPalette.object_palettes:
			var p : Palette = palette
			if white:
				p.palette = ColorUtils.shift_palette_right(p.palette, black)[0]
			else:
				p.palette = ColorUtils.shift_palette_left(p.palette, black)[0]
			
	emit_signal("finished_fade_out")
	pass

func blackout():
	
	
	var black = PoolColorArray()
	black.resize(fade_level)
	black.fill(Color.black)
	
	var background_palettes = GlobalPalette.background_palettes
	
	
	#blacken the whole thing
	for i in background_palettes.size():
		var background_palette : Palette = background_palettes[i]
		var shift = ColorUtils.shift_palette_left(background_palette.palette, black)
		background_palette.palette = shift[0]
		#store the original colors in base_bg
		base_bg.append(shift[1])
	
	var object_palettes = GlobalPalette.object_palettes
	
	#blacken the whole thing
	for i in object_palettes.size():
		var object_palette : Palette = object_palettes[i]
		var shift = ColorUtils.shift_palette_left(object_palette.palette, black)
		object_palette.palette = shift[0]
		#store the original colors in base_obj
		base_obj.append(shift[1])

func create_timer(time):
	return get_tree().create_timer(time, false)

func _ready() -> void:
	blackout()
