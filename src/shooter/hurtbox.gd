extends Area2D


func _on_hit(hitter):
	owner.get_hit(hitter)
	
