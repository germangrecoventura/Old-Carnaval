extends Control

onready var tween = $Tween
onready var background = $Background
onready var sprite = $Sprite

func _ready():
	$TimerEntry.start()
	tween.interpolate_property(sprite,"modulate",Color(0,0,0,0),Color(1,1,1,1.1),3.0)
	tween.start()


func _on_TimerEntry_timeout():
	$TimerOut.start()
	tween.interpolate_property(sprite,"modulate",Color(1,1,1,1),Color(0,0,0,0.0),3.0)
	tween.start()


func _on_TimerOut_timeout():
	$TimerOut.stop()
	get_tree().change_scene("res://scenes/Menu.tscn")   
	self.queue_free()
