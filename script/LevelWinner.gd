extends Control

signal e

export (String) var level
export (int) var dificulty
var pointNow: int

func _on_Retry_pressed():
	pass # Replace with function body.

func update_points():
	var point = Gamehandler.leardboard.get(level)[dificulty]
	$Panel/RecordActual/Record.text = String(point)
	$Panel/Score/Score.text = String(pointNow)

func _on_Next_pressed():
	get_tree().paused = false
	emit_signal("e")
	get_tree().change_scene("res://scenes/Menu.tscn")
	self.queue_free()
