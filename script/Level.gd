extends Control

var points = 0
var time = 3
onready var joystyck = $"Virtual joystick"
onready var touchAbduction = $ControlTouchAbduction/TouchAbduction
onready var audioStream = $SFX
onready var tween = $Tween
onready var transitionFinish = $TransitionFinish
onready var countdown = $CountDown
onready var animals_abducted = []
var paused: Object = null
onready var animationPlayer= $AnimationPlayer
onready var ufo= $Ufo
onready var timerFail= $TimerFail
onready var timerWinnerOne= $TimerWinnerOne
onready var timerWinnerTwo= $TimerWinnerTwo
onready var timerWinnerThree= $TimerWinnerThree
onready var animationUfo= $UfoAnimation
onready var cows= []


export (int) var level
export (String) var sceneFailed = "res://scenes/LevelFailed.tscn"
export (String) var sceneWinner = "res://scenes/LevelWinner.tscn"
export (String) var retry = "res://scenes/Level1.tscn"
export (String) var next = "res://scenes/Level2.tscn"


func _add_points(points_to_add):
	points += points_to_add
	
func add_animal(body):
	animals_abducted.append(body)

func _ready():
	for animal in get_tree().get_nodes_in_group("cow"):
		cows.append(animal.name)
	points = 0
	animationPlayer.play("background")
	$Ufo/Light/Area2D/CollisionShape2D.disabled = true
	joystyck.visible = false
	hide_ui()
	countdown.text = String(time%60)
	var audio_file = "res://sound/qubodup-(Ulrich Metzner Bell)-pre_start_race.ogg"
	var sfx = load(audio_file)
	audioStream.stream = sfx
	audioStream.play()

func on_information_quit() -> void:
	paused = null


func hide_ui() -> void:
	joystyck._reset()
	joystyck.set_process_input(false)
	joystyck.visible = false
	touchAbduction.set_process_input(false)
	touchAbduction.visible = false


func show_ui():
	joystyck.set_process_input(true)
	joystyck.visible = true
	touchAbduction.set_process_input(true)
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
		$TimerCountDown.queue_free()
		var audio_file = "res://sound/qubodup-(Ulrich Metzner Bell)-start_race.ogg"
		var sfx = load(audio_file)
		audioStream.stream = sfx
		audioStream.play()
		yield(get_tree().create_timer(0.90), "timeout")
		audioStream.stop()
	#	$Ufo/Ship/Light/Area2D/CollisionShape2D.disabled = false
		


func _on_TimerStart_timeout():
	countdown.text = "Go"
	show_ui()
	$TimerGo.start()
	

func _on_TimerGo_timeout():
	countdown.queue_free()
	$TimerTimeGame.start()
	


func _on_TimerTimeGame_timeout():
	touchAbduction.queue_free()
	animationUfo.stop()
	animationUfo.queue_free()
	ufo.queue_free()
	joystyck.queue_free()
	for child in $Animals.get_children():
			child.queue_free()
	if !animals_abducted.has("Cow"):
		transitionToFinish(timerFail,"res://sound/losegamemusic.ogg",4.16)
	elif points == 1:
		Gamehandler.update_leardboard(level,points)
		transitionToFinish(timerWinnerThree,"res://sound/winneris.ogg",3.87)
	elif points == 2:
		Gamehandler.update_leardboard(level,points)
		transitionToFinish(timerWinnerTwo,"res://sound/winneris.ogg",3.87)
	else:
		Gamehandler.update_leardboard(level,points)
		transitionToFinish(timerWinnerOne,"res://sound/winneris.ogg",3.87)


func _on_TimerFail_timeout():
	timerFail.queue_free()
	audioStream.stop()
	paused = load(sceneFailed).instance()
	add_child(paused)
	paused.update_results(retry,level)
	paused.connect("e",self,"on_information_quit")
	get_tree().paused = true


func _on_TimerWinnerOne_timeout():
	timerWinnerOne.queue_free()
	audioStream.stop()
	paused = load(sceneWinner).instance()
	activate_scene_winner(paused,"OneStar")

func _on_TimerWinnerTwo_timeout():
	timerWinnerTwo.queue_free()
	audioStream.stop()
	paused = load(sceneWinner).instance()
	activate_scene_winner(paused,"TwoStar")

func _on_TimerWinnerThree_timeout():
	timerWinnerThree.queue_free()
	audioStream.stop()
	paused = load(sceneWinner).instance()
	activate_scene_winner(paused,"ThreeStar")
	
func activate_scene_winner(scene,animation):
	add_child(scene)
	paused.activate_animation(animation)
	paused.update_results(retry,next,level,points)
	paused.connect("e",self,"on_information_quit")
	
	
func is_winner():
	var result = true
	for animal in cows:
		result = result && animals_abducted.has(animal)
	return result
