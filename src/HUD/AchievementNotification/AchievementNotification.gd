extends CanvasLayer

const ENTRY = preload("achievement_notification_entry.tscn")

onready var trail: VBoxContainer = $trail

func _ready() -> void:
	Achievements.connect("completed", self, "notify")

#func _process(delta: float) -> void:
#	visible = !visible
	
func notify(achievement:Achievement):
	var entry = ENTRY.instance()
	
	entry.title = achievement.title
	entry.description = achievement.description
	entry.texture = achievement.texture
	trail.add(entry)
	
	yield(get_tree().create_timer(7.5),"timeout")
	
	trail.remove(entry)
	entry.queue_free()
	pass
