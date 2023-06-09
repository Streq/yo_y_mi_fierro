extends Node

signal changed()

signal complete(achievement_name)
signal completed(achievement)

signal highscore(value)
signal highscore_updated()

signal highscore_endless(value)
signal highscore_endless_updated()

var map = {}

var highscore : int = 0
var highscore_endless : int = 0
export var unlocked_endless := false
onready var list: Node = $"%list"

func _ready() -> void:
	for achievement in list.get_children():
		map[achievement.name] = achievement
	
	
func complete(achievement_name):
	if map.has(achievement_name):
		var achievement : Achievement = map[achievement_name]
		if achievement.completed:
			return
		achievement.completed = true
		emit_signal("complete",achievement_name)
		emit_signal("completed",achievement)
		print("Achievement \"%s\" unlocked" % achievement.title)
		emit_signal("changed")
		
func is_complete(achievement_name):
	if map.has(achievement_name):
		var achievement : Achievement = map[achievement_name]
		return achievement.completed
	return false

func sync_achievements():
	for achievement in map.values():
		if achievement.completed:
			emit_signal("complete", achievement.name)

func clear():
	for achievement in map.values():
		achievement.completed = false
	highscore = 0
	highscore_endless = 0
	emit_signal("changed")
	emit_signal("highscore_updated")
	emit_signal("highscore_endless_updated")

func submit_highscore(score):
	highscore = max(highscore, score)
	emit_signal("highscore",score)
	emit_signal("highscore_updated")
	emit_signal("changed")

func submit_highscore_endless(score):
	highscore_endless = max(highscore_endless, score)
	emit_signal("highscore_endless",score)
	emit_signal("highscore_endless_updated")
	emit_signal("changed")

func unlock_endless():
	unlocked_endless = true
	emit_signal("changed")
