extends Node

var points
var time = 3
onready var touch = $"UI/Control2/Virtual joystick"
onready var touchAbduction = $UI/Control3/TouchAbduction
onready var audioStream = $SFX
onready var tween = $Tween
onready var colorRect = $UI/ColorRect
onready var countdown = $UI/CountDown
onready var animals_abducted = []
var SceneInformation: String = "res://scenes/InformationLevel.tscn"
var SceneFailed: String = "res://scenes/LevelFailed.tscn"
var SceneWinnerOneStar: String = "res://scenes/LevelWinnerOneStar.tscn"
var SceneWinnerTwoStar: String = "res://scenes/LevelWinnerTwoStar.tscn"
var SceneWinnerThreeStar: String = "res://scenes/LevelWinnerThreeStar.tscn"
var paused: Object = null
export (int) var dificulty

func _add_points(points_to_add):
	points += points_to_add
	
func add_animal(name):
	animals_abducted.append(name)

func _ready():
	$Ufo/Light/Area2D/CollisionShape2D.disabled = true
	$Cow.get_node("Body").set_material(load("res://shader/Animal.tres"))
	touch.visible = false
	points = 0
	$InformationLevel.connect("e",self,"on_information_quit")
	get_tree().paused = true
	hide_ui()
	countdown.text = String(time%60)
	var audio_file = "res://sound/qubodup-(Ulrich Metzner Bell)-pre_start_race.ogg"
	var sfx = load(audio_file)
	audioStream.stream = sfx
	audioStream.play()

func on_information_quit() -> void:
	paused = null


func hide_ui():
	touch.set_process_input(false)
	touchAbduction.set_process_input(false)
	touch.visible = false
	touchAbduction.visible = false


func show_ui():
	touch.set_process_input(true)
	touchAbduction.set_process_input(true)
	touch.visible = true
	touchAbduction.visible = true
	
func transition(time) -> void:
	tween.interpolate_property(colorRect,"color",Color(0,0,0,0),Color(0,0,0,0.70),time)
	tween.start()
	
func transitionToFailed():
	$TimerFail.start()
	transition(4.16)
	var audio_file = "res://sound/losegamemusic.ogg"
	var sfx = load(audio_file)
	audioStream.stream = sfx
	audioStream.play()
	
func transitionToWinnerStarOne():
	$TimerWinnerOne.start()
	transition(3.87)
	var audio_file = "res://sound/winneris.ogg"
	var sfx = load(audio_file)
	audioStream.stream = sfx
	audioStream.play()
	
	
func transitionToWinnerStarTwo():
	$TimerWinnerTwo.start()
	transition(3.87)
	var audio_file = "res://sound/winneris.ogg"
	var sfx = load(audio_file)
	audioStream.stream = sfx
	audioStream.play()
	
	
func transitionToWinnerStarThree():
	$TimerWinnerThree.start()
	transition(3.87)
	var audio_file = "res://sound/winneris.ogg"
	var sfx = load(audio_file)
	audioStream.stream = sfx
	audioStream.play()
	
	
	
func _on_TimerCountDown_timeout():
	if time > 1:
		time -= 1
		countdown.text = String(time%60)
	else:
		$TimerCountDown.stop()
		var audio_file = "res://sound/qubodup-(Ulrich Metzner Bell)-start_race.ogg"
		var sfx = load(audio_file)
		audioStream.stream = sfx
		audioStream.play()
		yield(get_tree().create_timer(0.90), "timeout")
		audioStream.stop()


func _on_TimerStart_timeout():
	countdown.text = "Go"
	show_ui()
	$TimerGo.start()
	

func _on_TimerGo_timeout():
	countdown.queue_free()
	$TimerTimeGame.start()
	


func _on_TimerTimeGame_timeout():
	hide_ui()
	if !animals_abducted.has("Cow"):
		transitionToFailed()
	elif points == 1:
		Gamehandler.update_leardboard("HammerLevel",dificulty,points)
		transitionToWinnerStarThree()
	elif points == 2:
		Gamehandler.update_leardboard("HammerLevel",dificulty,points)
		transitionToWinnerStarTwo()
	else:
		Gamehandler.update_leardboard("HammerLevel",dificulty,points)
		transitionToWinnerStarOne()


func _on_TimerFail_timeout():
	audioStream.stop()
	paused = load(SceneFailed).instance()
	paused.retry = "res://scenes/UfoLevel1.tscn"
	paused.level = "HammerLevel"
	paused.dificulty = dificulty
	paused.update_maximus_points()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true


func _on_TimerWinnerOne_timeout():
	audioStream.stop()
	paused = load(SceneWinnerOneStar).instance()
	paused.retry = "res://scenes/UfoLevel1.tscn"
	paused.next = "res://scenes/Menu.tscn"
	paused.level = "HammerLevel"
	paused.dificulty = dificulty
	paused.pointNow = points
	paused.update_points()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true


func _on_TimerWinnerTwo_timeout():
	audioStream.stop()
	paused = load(SceneWinnerTwoStar).instance()
	paused.retry = "res://scenes/UfoLevel1.tscn"
	paused.next = "res://scenes/Menu.tscn"
	paused.level = "HammerLevel"
	paused.dificulty = dificulty
	paused.pointNow = points
	paused.update_points()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true

func _on_TimerWinnerThree_timeout():
	audioStream.stop()
	paused = load(SceneWinnerThreeStar).instance()
	paused.retry = "res://scenes/UfoLevel1.tscn"
	paused.next = "res://scenes/Menu.tscn"
	paused.level = "HammerLevel"
	paused.dificulty = dificulty
	paused.pointNow = points
	paused.update_points()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true
