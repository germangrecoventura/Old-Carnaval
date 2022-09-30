extends Node2D

var time = 5
onready var touch = $UI/Touch

func _ready():
	touch.visible = false
	Gamehandler.puntos = 0
	get_tree().get_nodes_in_group("countdown")[0].text = String(time%60)
	$TimerStart.start()
	$AnimationPlayer.play("luz")
	$TimerGo.start()

func _on_TimerCountDown_timeout():
	if time != 1:
		time -= 1
		get_tree().get_nodes_in_group("countdown")[0].text = String(time%60)
	

func _on_TimerStart_timeout():
	get_tree().get_nodes_in_group("countdown")[0].queue_free()
	get_tree().get_nodes_in_group("go")[0].visible = true
	get_tree().get_nodes_in_group("go")[0].text = "Go"
	touch.visible = true
	$TimerGo.start()
	
	


func _on_TimerGo_timeout():
	get_tree().get_nodes_in_group("go")[0].visible = false
	$TimerTimeGame.start()
	


func _on_TimerTimeGame_timeout():
	touch.queue_free()
	if Gamehandler.puntos > 100:
		$AnimationPlayer.play("abducido")
		$TimerAnimationAbducion.start()
	elif Gamehandler.puntos > 40:
		$AnimationPlayer.play("fallo 2")
		$TimerFalloOne.start()
	else:
		$AnimationPlayer.play("fallo 1")
		$TimerFalloTwo.start()
	


func _on_TimerAnimationAbducion_timeout():
	$AnimationPlayer.play("fade")
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://scenes/Tutorial.tscn")   

func _on_TimerFalloOne_timeout():
	#$AnimationPlayer.play_backwards("fade")
	$AnimationPlayer.play("fade")
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://scenes/Menu.tscn")  


func _on_TimerFalloTwo_timeout():
	$AnimationPlayer.play("fade")
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://scenes/Menu.tscn")  
