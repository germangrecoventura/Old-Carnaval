extends Control

export var instructions = ""
signal e

func _on_Accept_pressed():
	get_tree().paused = false
	emit_signal("e")
	$TimerTransitionGame.start()
	$AnimationPlayer.play("transitionMovie")
	#yield(get_tree().create_timer(1), "timeout")
	

func _on_TimerTransitionGame_timeout():
	self.queue_free()
	
func _on_Cancel_pressed():
	get_tree().paused = false
	emit_signal("e")
	get_tree().change_scene("res://scenes/Menu.tscn")
