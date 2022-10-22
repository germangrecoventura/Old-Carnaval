extends Node
signal e

func _on_Accept_pressed():
	#get_tree().paused = false
	#emit_signal("e")
	#$TimerTransitionGame.start()
	#$AnimationPlayer.play("transitionMovie")
	#$Control/Container.set_process(false)
	pass

func _on_TimerTransitionGame_timeout():
	pass
	#self.queue_free()
	
func _on_Cancel_pressed():
	pass
	#get_tree().paused = false
	#emit_signal("e")
	#get_tree().change_scene("res://scenes/Menu.tscn")
	#self.queue_free()
