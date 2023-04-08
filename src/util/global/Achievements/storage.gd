extends Node

var SAVE_PATH := "user://achievements.save"

export var disabled := false

const HIGHSCORE = "highscore"

func load_from_file():
	if disabled:
		return
	var save_game : File = File.new()
	
	if save_game.open(SAVE_PATH, File.READ) == 0:
			
		var save = save_game.get_var()
		if !save:
			return
		for achievement in owner.map.values():
			if save.has(achievement.name):
				var val = save[achievement.name]
				achievement.completed = val
				print(achievement.name," ",achievement.completed)
		if save.has(HIGHSCORE):
			var val = save[HIGHSCORE]
			owner.highscore = val
	save_game.close()

func clear():
	owner.clear()
	
	

func save_to_file():
	var save_game = File.new()
	save_game.open(SAVE_PATH, File.WRITE)
	
	var save = {}
	
	for achievement in owner.map.values():
		var val = achievement.completed
		save[achievement.name] = val
	save[HIGHSCORE] = owner.highscore
	save_game.store_var(save)
	save_game.close()
