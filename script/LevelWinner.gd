extends Control

signal e

var pointNow: int
var stars_to_add = 3
onready var star_one = $StarOne
onready var star_two = $StarTwo
onready var star_three = $StarThree
onready var estrellas = [star_one,star_two,star_three]
onready var audioStream = $SFX
onready var animationStar = $AnimationPlayer

export (int) var level
export (String) var retry
export (PackedScene) var listLevel
export (String) var next

func _ready():
	$Particles2D.emitting = false
	star_one.visible = false
	star_two.visible = false
	star_three.visible = false
	$RecordActual.visible = false
	$Score.visible = false
	$VBoxContainer.visible = false
	
func activate_animation(star):
	match star:
		"OneStar":
		   animationStar.play(star)
		"TwoStar":
			animationStar.play(star)
		_:
			animationStar.play(star)
	
	
func acept_signal():
	get_tree().paused = false
	emit_signal("e")
	self.queue_free()
	
func _on_Retry_pressed():
	acept_signal()
	get_tree().change_scene(retry)


func update_results(retryToPlay,nextToPlay,levelToPlay,pointToGame):
	self.retry = retryToPlay
	self.next = nextToPlay
	self.level = levelToPlay
	self.pointNow = pointToGame
	var point = Gamehandler.leardboard[level]
	$RecordActual/Record.text = String(point)
	$Score/Score.text = String(pointNow)


func _on_Next_pressed():
	acept_signal()
	get_tree().change_scene(next)


func _on_ListLevel_pressed():
	acept_signal()
	get_tree().change_scene_to(listLevel)
