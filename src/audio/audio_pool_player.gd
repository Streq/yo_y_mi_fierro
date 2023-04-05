extends Node


func play():
	for child in get_children():
		var audio : AudioStreamPlayer = child
		if !audio.playing:
			audio.play()
#			print("play")
			return
	pass
