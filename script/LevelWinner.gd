extends Control

signal e

var level:int
var pointNow: int
var retry:String
var next:String
var stars_to_add = 3
onready var star_one = $StarOne
onready var star_two = $StarTwo
onready var star_three = $StarThree
onready var estrellas = [star_one,star_two,star_three]
onready var audioStream = $SFX
onready var animationStar = $AnimationPlayer

func _ready():
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
	
func _on_Retry_pressed():
	get_tree().paused = false
	emit_signal("e")
	get_tree().change_scene(retry)
	self.queue_free()

func update_points():
	var point = Gamehandler.leardboard[level]
	$RecordActual/Record.text = String(point)
	$Score/Score.text = String(pointNow)

func _on_Next_pressed():
	get_tree().paused = false
	emit_signal("e")
	get_tree().change_scene(next)
	self.queue_free()
