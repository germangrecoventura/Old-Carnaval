extends Node2D

var points = 0
var time = 5
onready var touch = $UI/ButtonForAddPoints
var SceneInformation: String = "res://scenes/InformationLevel.tscn"
var SceneFailed: String = "res://scenes/LevelFailed.tscn"
var paused: Object = null


func _ready():
	points = 0
	paused = load(SceneInformation).instance()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true
	touch.visible = false
	get_tree().get_nodes_in_group("countdown")[0].text = String(time%60)
	$TimerStart.start()
	$AnimationPlayer.play("luz")
	$TimerGo.start()

func on_information_quit() -> void:
	paused = null
	
func transitionToFailed():
	$AnimationPlayer.play("fade")
	yield(get_tree().create_timer(1), "timeout")
	print(points)
	Gamehandler.update_leardboard("HammerLevel",0,points)
	print(Gamehandler.leardboard)
	paused = load(SceneFailed).instance()
	paused.update_maximus_points()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true
	

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
	if points > 100:
		$AnimationPlayer.play("abducido")
		$TimerAbduct.start()
	elif points > 40:
		$AnimationPlayer.play("failMedium")
		$TimerFailMedium.start()
	else:
		$AnimationPlayer.play("failLow")
		$TimerFailLow.start()
	


func _on_TimerAbduct_timeout():
	$AnimationPlayer.play("fade")
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://scenes/Tutorial.tscn")   

func _on_TimerFailMedium_timeout():
	#$AnimationPlayer.play_backwards("fade")
	transitionToFailed()


func _on_TimerFailLow_timeout():
	transitionToFailed()
	


