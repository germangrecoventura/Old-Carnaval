extends Control

var points
var time = 3
onready var touch = $"Virtual joystick"
onready var touchAbduction = $ControlTouchAbduction/TouchAbduction
onready var audioStream = $SFX
onready var tween = $Tween
onready var transitionFinish = $TransitionFinish
onready var countdown = $CountDown
onready var animals_abducted = []
var SceneInformation: String = "res://scenes/InformationLevel.tscn"
var SceneFailed: String = "res://scenes/LevelFailed.tscn"
var SceneWinnerOneStar: String = "res://scenes/LevelWinnerOneStar.tscn"
var SceneWinnerTwoStar: String = "res://scenes/LevelWinnerTwoStar.tscn"
var SceneWinnerThreeStar: String = "res://scenes/LevelWinnerThreeStar.tscn"
var paused: Object = null
onready var animationPlayer= $AnimationPlayer


export (int) var level = 0
export (String) var retry = "res://scenes/Level1.tscn"

func _add_points(points_to_add):
	points += points_to_add
	
func add_animal(name):
	animals_abducted.append(name)

func _ready():
	$Background.texture= load("res://assets/background transition/Amanecer00.png")
	$Ufo/Ship/Light/Area2D/CollisionShape2D.disabled = true
	touch.visible = false
	points = 0
	hide_ui()
	countdown.text = String(time%60)
	var audio_file = "res://sound/qubodup-(Ulrich Metzner Bell)-pre_start_race.ogg"
	var sfx = load(audio_file)
	audioStream.stream = sfx
	audioStream.play()

func on_information_quit() -> void:
	paused = null


func hide_ui() -> void:
	touch._reset()
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
	tween.interpolate_property(transitionFinish,"color",Color(0,0,0,0),Color(0,0,0,0.70),time)
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
		$Ufo/Ship/Light/Area2D/CollisionShape2D.disabled = false
		animationPlayer.play("background")
		


func _on_TimerStart_timeout():
	countdown.text = "Go"
	show_ui()
	$TimerGo.start()
	

func _on_TimerGo_timeout():
	countdown.queue_free()
	$TimerTimeGame.start()
	


func _on_TimerTimeGame_timeout():
	hide_ui()
	for child in $Animals.get_children():
			child.queue_free()
	if !animals_abducted.has("Cow"):
		transitionToFailed()
	elif points == 1:
		Gamehandler.update_leardboard(level,points)
		transitionToWinnerStarThree()
	elif points == 2:
		Gamehandler.update_leardboard(level,points)
		transitionToWinnerStarTwo()
	else:
		Gamehandler.update_leardboard(level,points)
		transitionToWinnerStarOne()


func _on_TimerFail_timeout():
	audioStream.stop()
	paused = load(SceneFailed).instance()
	paused.retry = "res://scenes/Level1.tscn"
	paused.level = level
	paused.update_maximus_points()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true


func _on_TimerWinnerOne_timeout():
	audioStream.stop()
	paused = load(SceneWinnerOneStar).instance()
	paused.retry = retry
	paused.next = "res://scenes/Menu.tscn"
	paused.level = 0
	paused.pointNow = points
	paused.update_points()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true


func _on_TimerWinnerTwo_timeout():
	audioStream.stop()
	paused = load(SceneWinnerTwoStar).instance()
	paused.retry = "res://scenes/Level1.tscn"
	paused.next = "res://scenes/Menu.tscn"
	paused.level = 0
	paused.pointNow = points
	paused.update_points()
	add_child(paused)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true

func _on_TimerWinnerThree_timeout():
	audioStream.stop()
	paused = load(SceneWinnerThreeStar).instance()
	paused.retry = "res://scenes/Level1.tscn"
	paused.next = "res://scenes/Menu.tscn"
	paused.level = 0
	paused.pointNow = points
	paused.update_points()
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true
	add_child(paused)
	
	
	
