extends Control

func _ready():
	Gamehandler.leardboard = {"HammerLevel": [0,0,0]}

func _on_Play_pressed():
	get_tree().change_scene("res://scenes/HammerLevel.tscn")   


func _on_Credits_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")  
