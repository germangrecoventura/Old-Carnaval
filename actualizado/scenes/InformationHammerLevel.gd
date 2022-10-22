extends "res://script/InformationHammerLevel.gd"
onready var tween = $"../Tween"
onready var selected = true

func hide_information() -> void:
	tween.interpolate_property($Information,"modulate",Color(1,1,1,1),Color(0,0,0,0.0),1.0)
	tween.start()

func _on_Accept_pressed():
	if(selected):
		selected = false
		get_tree().paused = false
		emit_signal("e")
		$TimerTransitionGame.start()
		selected = false
		$AnimationPlayer.play("transitionMovie")
		hide_information()
	

func _on_TimerTransitionGame_timeout():
	self.queue_free()
	
func _on_Cancel_pressed():
	get_tree().paused = false
	emit_signal("e")
	get_tree().change_scene("res://scenes/Menu.tscn")
	self.queue_free()
