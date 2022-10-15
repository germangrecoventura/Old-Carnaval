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

func _ready():
	points = 0
	paused = load(SceneInformation).instance()
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
	get_tree().get_nodes_in_group("countdown")[0].queue_free()
	get_tree().get_nodes_in_group("go")[0].visible = true
	get_tree().get_nodes_in_group("go")[0].text = "Go"
	show_ui()
	$TimerGo.start()
	

func _on_TimerGo_timeout():
	get_tree().get_nodes_in_group("go")[0].visible = false
	$TimerTimeGame.start()
	


func _on_TimerTimeGame_timeout():
	hide_ui()
	Gamehandler.update_leardboard("HammerLevel",dificulty,points)
	if points > 600:
		#$AnimationPlayer.play("abduct")
		$TimerAbduct.start()
	elif points > 400:
		$AnimationPlayer.play("failMedium")
		$TimerFailMedium.start()
	else:
		#$AnimationPlayer.play("failLow")
		var audio_file = "res://sound/losegamemusic.ogg"
		var sfx = load(audio_file)
		audioStream.stream = sfx
		audioStream.play()
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
	