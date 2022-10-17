extends Node2D

var points
var time = 3
onready var touchLeft = $UI/TouchLeft
onready var touchRight = $UI/TouchRight
onready var touchAbduction = $UI/TouchAbduction
onready var audioStream = $SFX
var SceneInformation: String = "res://scenes/InformationLevel.tscn"
var SceneFailed: String = "res://scenes/LevelFailed.tscn"
var SceneWinnerOneStar: String = "res://scenes/LevelWinnerOneStar.tscn"
var SceneWinnerTwoStar: String = "res://scenes/LevelWinnerTwoStar.tscn"
var SceneWinnerThreeStar: String = "res://scenes/LevelWinnerThreeStar.tscn"
var paused: Object = null
export (int) var dificulty

func _add_points(points_to_add):
	points += points_to_add

func _ready():
	points = 0
	paused = load(SceneInformation).instance()
	paused.text_panel("Abduct the cow with the fewest attempts. \n\n Watch out for the rest of the animals.")
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true
	hide_ui()
	get_tree().get_nodes_in_group("countdown")[0].text = String(time%60)
	$TimerStart.start()
	var audio_file = "res://sound/qubodup-(Ulrich Metzner Bell)-pre_start_race.ogg"
	var sfx = load(audio_file)
	audioStream.stream = sfx
	audioStream.play()
	#$AnimationPlayer.play("light")

func on_information_quit() -> void:
	paused = null


func hide_ui():
	touchLeft.visible = false
	touchRight.visible = false
	touchAbduction.visible = false


func show_ui():
	touchLeft.visible = true
	touchRight.visible = true
	touchAbduction.visible = true
	
	
func transitionToFailed():
	$AnimationPlayer.play("fade")
	yield(get_tree().create_timer(1), "timeout")
	paused = load(SceneFailed).instance()
	paused.retry = "res://scenes/HammerLevel.tscn"
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
	paused.retry = "res://scenes/HammerLevel.tscn"
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
	paused.retry = "res://scenes/HammerLevel.tscn"
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
	paused.retry = "res://scenes/HammerLevel.tscn"
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
	else:
		var audio_file = "res://sound/qubodup-(Ulrich Metzner Bell)-pre_start_race.ogg"
		var sfx = load(audio_file)
		audioStream.stream = sfx
	

func _on_TimerStart_timeout():
	#var audio_file = "res://sound/qubodup-(Ulrich Metzner Bell)-start_race.ogg"
	#var sfx = load(audio_file)
	#audioStream.stream = sfx
	audioStream.play()
	yield(get_tree().create_timer(1), "timeout")
	audioStream.stop()
	$TimerGo.start()
	get_tree().get_nodes_in_group("countdown")[0].text = "Go"
	show_ui()
	$TimerGo.start()
	

func _on_TimerGo_timeout():
	get_tree().get_nodes_in_group("countdown")[0].queue_free()
	$TimerTimeGame.start()
	


func _on_TimerTimeGame_timeout():
	hide_ui()
	Gamehandler.update_leardboard("HammerLevel",dificulty,points)
	if points == 1:
		transitionToWinnerStarThree()
	elif points == 2:
		transitionToWinnerStarTwo()
	elif points == 3:
		transitionToWinnerStarOne()
	else:
		var audio_file = "res://sound/losegamemusic.ogg"
		var sfx = load(audio_file)
		audioStream.stream = sfx
		audioStream.play()
		$TimerFail.start()
	

func _on_TimerFail_timeout():
	transitionToFailed()
