extends Control

signal e

var level:int
var dificulty:String
var pointNow: int
var retry:String
var next:String

func _on_Retry_pressed():
	get_tree().paused = false
	emit_signal("e")
	get_tree().change_scene(retry)
	self.queue_free()

func update_points():
	var point = Gamehandler.leardboard.get(level)[dificulty]
	$RecordActual/Record.text = String(point)
	$Score/Score.text = String(pointNow)

func _on_Next_pressed():
	get_tree().paused = false
	emit_signal("e")
	get_tree().change_scene(next)
	self.queue_free()
