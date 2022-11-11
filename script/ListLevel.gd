extends Node

func _on_Level1_pressed():
	self.queue_free()
	get_tree().change_scene("res://scenes/Level1.tscn")


func _on_Level2_pressed():
	self.queue_free()
	get_tree().change_scene("res://scenes/Level2.tscn")


func _on_Level3_pressed():
	get_tree().change_scene("res://scenes/Level3.tscn")


func _on_Return_pressed():
	self.queue_free()
	get_tree().change_scene("res://scenes/Menu.tscn")
