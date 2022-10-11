extends Node2D

var points
var time = 3
onready var touchLeft = $UI/TouchLeft
onready var touchRight = $UI/TouchRight
var SceneInformation: String = "res://scenes/InformationLevel.tscn"
var SceneFailed: String = "res://scenes/LevelFailed.tscn"
var SceneWinnerOneStar: String = "res://scenes/LevelWinnerOneStar.tscn"
var SceneWinnerTwoStar: String = "res://scenes/LevelWinnerTwoStar.tscn"
var SceneWinnerThreeStar: String = "res://scenes/LevelWinnerThreeStar.tscn"
var paused: Object = null
export (int) var dificulty

func _ready():
	points = 0
	paused = load(SceneInformation).instance()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true
	touchLeft.visible = false
	touchRight.visible = false
	get_tree().get_nodes_in_group("countdown")[0].text = String(time%60)
	$TimerStart.start()
	$AnimationPlayer.play("light")

func on_information_quit() -> void:
	paused = null
	
func transitionToFailed():
	$AnimationPlayer.play("fade")
	yield(get_tree().create_timer(1), "timeout")
	paused = load(SceneFailed).instance()
	paused.level = "HammerLevel"
	paused.dificulty = dificulty
	paused.update_maximus_points()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true
	
func transitionToWinnerStarOne():
	$AnimationPlayer.play("fade")
	yield(get_tree().create_timer(1), "timeout")
	paused = load(SceneWinnerOneStar).instance()
	paused.level = "HammerLevel"
	paused.dificulty = dificulty
	paused.pointNow = points
	paused.update_points()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true
	
func transitionToWinnerStarTwo():
	$AnimationPlayer.play("fade")
	yield(get_tree().create_timer(1), "timeout")
	paused = load(SceneWinnerTwoStar).instance()
	paused.level = "HammerLevel"
	paused.dificulty = dificulty
	paused.pointNow = points
	paused.update_points()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true
	
func transitionToWinnerStarThree():
	$AnimationPlayer.play("fade")
	yield(get_tree().create_timer(1), "timeout")
	paused = load(SceneWinnerThreeStar).instance()
	paused.level = "HammerLevel"
	paused.dificulty = dificulty
	paused.pointNow = points
	paused.update_points()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true
	
	
func _on_TimerCountDown_timeout():
	if time != 1:
		time -= 1
		get_tree().get_nodes_in_group("countdown")[0].text = String(time%60)
	

func _on_TimerStart_timeout():
	$TimerGo.start()
	get_tree().get_nodes_in_group("countdown")[0].queue_free()
	get_tree().get_nodes_in_group("go")[0].visible = true
	get_tree().get_nodes_in_group("go")[0].text = "Go"
	touchLeft.visible = true
	touchRight.visible = true
	$TimerGo.start()
	$TimerPositionCow.start()
	
	


func _on_TimerGo_timeout():
	get_tree().get_nodes_in_group("go")[0].visible = false
	$TimerTimeGame.start()
	


func _on_TimerTimeGame_timeout():
	touchLeft.visible= false
	touchRight.visible= false
	Gamehandler.update_leardboard("HammerLevel",dificulty,points)
	if points > 600:
		$AnimationPlayer.play("abduct")
		$TimerAbduct.start()
	elif points > 400:
		$AnimationPlayer.play("failMedium")
		$TimerFailMedium.start()
	else:
		$AnimationPlayer.play("failLow")
		$TimerFailLow.start()
	


func _on_TimerAbduct_timeout():
	if points > 900:
		transitionToWinnerStarThree()
	elif points > 750:
		transitionToWinnerStarTwo()
	else:
		transitionToWinnerStarOne()

func _on_TimerFailMedium_timeout():
	#$AnimationPlayer.play_backwards("fade")
	transitionToFailed()


func _on_TimerFailLow_timeout():
	transitionToFailed()
	




func _on_TimerPositionCow_timeout():
	$Cow.position.x = rand_range(810,819)
