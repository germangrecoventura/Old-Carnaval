extends Node

signal e

export (String) var level
export (int) var dificulty
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
	$Control/RecordActual/Record.text = String(point)
	$Control/Score/Score.text = String(pointNow)

func _on_Next_pressed():
	get_tree().paused = false
	emit_signal("e")
	get_tree().change_scene(next)
	self.queue_free()
