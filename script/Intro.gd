extends Node

onready var tween = $Tween
onready var background = $Background
onready var logo = $Logo
onready var ufo = $Ufo
onready var timerEntryLogo = $TimerEntryLogo
onready var timerEntryUfo = $TimerEntryUfo
onready var timerOutLogo = $TimerOutLogo
onready var timerOutUfo = $TimerOutUfo

func _ready():
	$TimerEntryLogo.start()
	tween.interpolate_property(logo,"modulate",Color(0,0,0,0),Color(1,1,1,1.1),timerEntryLogo.wait_time)
	tween.start()


func _on_TimerEntryLogo_timeout():
	$TimerEntryUfo.start()
	tween.interpolate_property(ufo,"rect_position",ufo.rect_position,Vector2(ufo.rect_position.x,105),timerEntryUfo.wait_time)
	tween.start()
	
	
func _on_TimerEntryUfo_timeout():
	$TimerOutLogo.start()
	tween.interpolate_property(logo,"modulate",Color(1,1,1,1),Color(0,0,0,0.0),timerOutLogo.wait_time)
	tween.start()

	
func _on_TimerOutLogo_timeout():
	$TimerOutUfo.start()
	tween.interpolate_property(ufo,"rect_position",ufo.rect_position,Vector2(ufo.rect_position.x,-175),timerOutUfo.wait_time)
	tween.start()


func _on_TimerOutUfo_timeout():
	$TimerOutUfo.stop()
	get_tree().change_scene("res://scenes/Menu.tscn")   
	self.queue_free()


