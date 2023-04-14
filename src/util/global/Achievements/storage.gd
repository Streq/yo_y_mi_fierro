extends Node

var SAVE_PATH := "user://achievements.save"

export var disabled := false

const HIGHSCORE = "highscore"
const HIGHSCORE_ENDLESS = "highscore_endless"
const UNLOCKED_ENDLESS = "unlocked_endless"
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
			owner.set(HIGHSCORE, val)
		if save.has(HIGHSCORE_ENDLESS):
			var val = save[HIGHSCORE_ENDLESS]
			owner.set(HIGHSCORE_ENDLESS, val)
		if save.has(UNLOCKED_ENDLESS):
			var val = save[UNLOCKED_ENDLESS]
			if !val:
				val = Achievements.map["beat_boss"].completed
			owner.set(UNLOCKED_ENDLESS, val)
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
	save[HIGHSCORE] = owner.get(HIGHSCORE)
	save[HIGHSCORE_ENDLESS] = owner.get(HIGHSCORE_ENDLESS)
	save[UNLOCKED_ENDLESS] = owner.get(UNLOCKED_ENDLESS)
	save_game.store_var(save)
	save_game.close()
	
