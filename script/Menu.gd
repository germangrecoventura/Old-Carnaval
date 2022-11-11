extends Control

export (PackedScene) var scene_play
export (PackedScene) var credits

func _on_Play_pressed():
	self.queue_free()
	get_tree().change_scene_to(scene_play)   


func _on_Credits_pressed():
	self.queue_free()
	get_tree().change_scene_to(credits)  
