extends Control

var points = 0
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
onready var SceneWinner: String = "res://scenes/LevelWinner.tscn"
var paused: Object = null
onready var animationPlayer= $AnimationPlayer


export (int) var level = 0
export (String) var retry = "res://scenes/Level2.tscn"
#export (PackedScene) var retry


func _add_points(points_to_add):
	points += points_to_add
	
func add_animal(name):
	animals_abducted.append(name)

func _ready():
	animationPlayer.play("background")
	$Ufo/Ship/Light/Area2D/CollisionShape2D.disabled = true
	touch.visible = false
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
	
	
func transitionToFinish(timer,sound,time):
	timer.start()
	transition(time)
	var audio_file = sound
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
		


func _on_TimerStart_timeout():
	countdown.text = "Go"
	show_ui()
	$TimerGo.start()
	

func _on_TimerGo_timeout():
	countdown.queue_free()
	$TimerTimeGame.start()
	


func _on_TimerTimeGame_timeout():
	$Ufo.queue_free()
	$"Virtual joystick".queue_free()
	$ControlTouchAbduction.queue_free()
	for child in $Animals.get_children():
			child.queue_free()
	if !animals_abducted.has("Cow"):
		transitionToFinish($TimerFail,"res://sound/losegamemusic.ogg",4.16)
	elif points == 1:
		Gamehandler.update_leardboard(level,points)
		transitionToFinish($TimerWinnerThree,"res://sound/winneris.ogg",3.87)
	elif points == 2:
		Gamehandler.update_leardboard(level,points)
		transitionToFinish($TimerWinnerTwo,"res://sound/winneris.ogg",3.87)
	else:
		Gamehandler.update_leardboard(level,points)
		transitionToFinish($TimerWinnerOne,"res://sound/winneris.ogg",3.87)


func _on_TimerFail_timeout():
	$TimerFail.queue_free()
	audioStream.stop()
	paused = load(SceneFailed).instance()
	add_child(paused)
	paused.retry = "res://scenes/Level1.tscn"
	paused.level = 0
	paused.update_maximus_points()
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true


func _on_TimerWinnerOne_timeout():
	$TimerWinnerOne.queue_free()
	audioStream.stop()
	paused = load(SceneWinner).instance()
	add_child(paused)
	paused.activate_animation("OneStar")
	paused.retry = "res://scenes/Level1.tscn"
	paused.next = "res://scenes/Menu.tscn"
	paused.level = 0
	paused.pointNow = points
	paused.update_points()
	paused.connect("e",self,"on_information_quit")


func _on_TimerWinnerTwo_timeout():
	$TimerWinnerTwo.queue_free()
	audioStream.stop()
	paused = load(SceneWinner).instance()
	add_child(paused)
	paused.activate_animation("TwoStar")
	paused.retry = "res://scenes/Level1.tscn"
	paused.next = "res://scenes/Menu.tscn"
	paused.level = 0
	paused.pointNow = points
	paused.update_points()
	paused.connect("e",self,"on_information_quit")

func _on_TimerWinnerThree_timeout():
	$TimerWinnerThree.queue_free()
	audioStream.stop()
	paused = load(SceneWinner).instance()
	add_child(paused)
	paused.activate_animation("ThreeStar")
	paused.retry = "res://scenes/Level1.tscn"
	paused.next = "res://scenes/Menu.tscn"
	paused.level = 0
	paused.pointNow = points
	paused.update_points()
	paused.connect("e",self,"on_information_quit")
	
	
	
