extends GridContainer

var ENTRY := preload("./achievement_entry.tscn")

onready var title: Label = $"%title"
onready var requirement: Label = $"%requirement"


func _ready() -> void:
	for child in get_children():
		remove_child(child)
	for id in Achievements.map:
		var achievement : Achievement = Achievements.map[id]
		if achievement.hidden:
			continue
		var entry = ENTRY.instance()
		entry.texture = achievement.texture
		entry.name = id
		entry.connect("focus_entered",self,"display_achievement",[achievement])
		
		if achievement.completed:
			entry.completed()
		achievement.connect("completed",entry,"completed")
		achievement.connect("reset",entry,"reset")
		add_child(entry)
	connect("focus_entered",get_child(0),"grab_focus")
	
func display_achievement(achievement):
	title.text = achievement.title
	requirement.text = achievement.description
