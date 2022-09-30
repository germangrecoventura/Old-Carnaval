extends Control

export var instructions = ""


func _process(delta):
	if Input.is_action_just_pressed("accept"):
		$TimerTransitionGame.start()
		$AnimationPlayer.play("transitionMovie")
	if Input.is_action_just_pressed("cancel"):
		get_tree().change_scene("res://scenes/Menu.tscn")


func _on_TimerTransitionGame_timeout():
	visible = false
